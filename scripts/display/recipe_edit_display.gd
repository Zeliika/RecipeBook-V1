extends Control

## The text field containing the recipe name
@onready var title_edit: LineEdit = %TitleEdit
## The text field containing the recipe description
@onready var description_edit: TextEdit = %Description
## The container holding ingredient schenes
@onready var ingredient_list_container: VBoxContainer = %IngredientListContainer
## The buttton to add an ingredient
@onready var add_ingredient_button: Button = %AddIngredientButton
@onready var tag_selector : MenuButton = %TagSelector
## The recipe that is edited or null if new recipe is added
var recipe_data : RecipeData
## The scene to display and edit ingredients
var ingredient_edit_display_scene : PackedScene = preload("res://scenes/ingredient_edit_display.tscn")

var tag_popup : PopupMenu

var currently_selected : int = -1

func _ready() -> void:
	## initialize dropdown with values from unit enum
	tag_popup = tag_selector.get_popup()
	tag_popup.max_size = Vector2i(tag_popup.max_size.x, size.y * 0.8)
	tag_popup.hide_on_checkable_item_selection = false
	for tag in GlobalTypes.get_tags_alphabetical():
		tag_popup.add_check_item(GlobalTypes.tag_to_text(tag), tag)
	tag_popup.connect("index_pressed", select_tag)

## Initialize UI fields
func init(recipe_data : RecipeData = null) -> void:
	## Save recipe data for later use
	self.recipe_data = recipe_data

	## If recipe data is null than we add a new recipe and no UI fields have to be initialized
	if recipe_data == null:
		return

	## Initialize recipe name field
	title_edit.text = recipe_data.recipe_name

	for i in range(0, tag_popup.item_count):
		if recipe_data.tags.has(tag_popup.get_item_id(i)):
			tag_popup.set_item_checked(i, true)

	## Initialize ingredient list ui
	for ingredient in recipe_data.ingredients:
		add_ingredient_edit_line(ingredient)

	## Initialize description text field
	description_edit.text = recipe_data.description

func select_tag(index : int) -> void:
	tag_popup.set_item_checked(index, not tag_popup.is_item_checked(index))

func add_ingredient_edit_line(ingredient : IngredientData) -> void:
	var display = ingredient_edit_display_scene.instantiate()
	ingredient_list_container.add_child(display)
	display.init(ingredient)
	display.get_button().connect("pressed",delete_ingredient_edit_line.bind(display))
	display.connect("ingredient_selected", on_ingredient_selected)


## TODO Replace with drag and drop behaviour
func on_ingredient_selected(index : int, selected : bool) -> void:
	if selected:
		for child in ingredient_list_container.get_children():
			if child.get_index() != index:
				child.deselect_ingredient()
		currently_selected = index
	else:
		currently_selected = -1

func delete_ingredient_edit_line(ingredient_edit_line : Control = null) -> void:
	if ingredient_edit_line == null:
		print_debug("Trying to delete not existing ingredient")
		return
	ingredient_edit_line.queue_free()


## Reload this scene, when reset button is pressed
func _on_reset_button_pressed() -> void:
	SceneManager.load_edit_recipe(recipe_data)


## Return to recipe display schene when cancel is pressed
func _on_cancel_button_pressed() -> void:
	if recipe_data == null:
		SceneManager.load_main_menu()
		return
	SceneManager.load_recipe_scene(recipe_data)
	#TODO return to main menu when recipe was null (no recipe scene to return to)


## Update the recipe data when save button is pressed
## In case of new recipe the recipe has to be added to recipe book
func _on_save_button_pressed() -> void:
	## Read data from UI fields
	var recipe_name := title_edit.text
	var tag_list : Array[GlobalTypes.Tag] = []
	for i in range(0, tag_popup.item_count):
		if tag_popup.is_item_checked(i):
			tag_list.append(tag_popup.get_item_id(i))
	var ingredient_list : Array[IngredientData] = []
	for ingredient_edit_display in ingredient_list_container.get_children():
		ingredient_list.append(ingredient_edit_display.get_ingredient_data())
	var description := description_edit.text

	## Create new recipe data in case of adding a new recipe
	if recipe_data == null:
		recipe_data = RecipeData.new() #TODO add recipe to recipe book
		RecipeBookManager.add_recipe(recipe_data)
	## Update recipe data with data read from UI fields previously
	recipe_data.recipe_name = recipe_name
	recipe_data.tags = tag_list
	recipe_data.ingredients = ingredient_list
	recipe_data.description = description
	RecipeBookManager.save_recipe_book_data()
	SceneManager.load_recipe_scene(recipe_data)


func _on_add_ingredient_button_pressed() -> void:
	add_ingredient_edit_line(null)


## TODO Replace with drag and drop behaviour
func _on_up_button_pressed() -> void:
	print(currently_selected)
	if currently_selected > 0:
		ingredient_list_container.move_child(ingredient_list_container.get_child(currently_selected), currently_selected - 1)
		currently_selected -= 1

## TODO Replace with drag and drop behaviour
func _on_down_button_pressed() -> void:
	print(currently_selected)
	if currently_selected < ingredient_list_container.get_child_count() - 1 and currently_selected >= 0:
		ingredient_list_container.move_child(ingredient_list_container.get_child(currently_selected), currently_selected + 1)
		currently_selected += 1
