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

func _ready() -> void:
	## initialize dropdown with values from unit enum
	tag_selector.get_popup().hide_on_checkable_item_selection = false
	for tag in GlobalTypes.Tag.values():
		tag_selector.get_popup().add_check_item(GlobalTypes.tag_to_text(tag), tag)

## Initialize UI fields
func init(recipe_data : RecipeData = null) -> void:
	## Save recipe data for later use
	self.recipe_data = recipe_data

	## If recipe data is null than we add a new recipe and no UI fields have to be initialized
	if recipe_data == null:
		return

	## Initialize recipe name field
	title_edit.text = recipe_data.recipe_name

	## Initialize ingredient list ui
	for ingredient in recipe_data.ingredients:
		add_ingredient_edit_line(ingredient)

	## Initialize description text field
	description_edit.text = recipe_data.description

func add_ingredient_edit_line(ingredient : IngredientData) -> void:
	var display = ingredient_edit_display_scene.instantiate()
	ingredient_list_container.add_child(display)
	display.init(ingredient)
	display.get_button().connect("pressed",delete_ingredient_edit_line.bind(display))

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
	recipe_data.ingredients = ingredient_list
	recipe_data.description = description
	RecipeBookManager.save_recipe_book_data()
	SceneManager.load_recipe_scene(recipe_data)
#TODO save recipe book



func _on_add_ingredient_button_pressed() -> void:
	add_ingredient_edit_line(null)



