extends Control

class_name RecipeBookDisplay
## Class to manager recipe book ui components

## UI scene for recipe preview
@onready var recipe_preview_scene : PackedScene = preload("res://scenes/recipe_preview.tscn")
@onready var file_dialog: FileDialog = %FileDialog
@onready var text_search_field: LineEdit = %TextSearchField
@onready var recipe_list: VBoxContainer = %RecipeList
@onready var tag_selector = %TagSelector
@onready var import_recipe_button: Button = %ImportRecipeButton
@onready var export_recipe_button_: Button = %"ExportRecipeButton#"
@onready var add_recipe_button: Button = %AddRecipeButton
@onready var delete_recipes_button: Button = %DeleteRecipesButton
@onready var selection_button: Button = %SelectionButton

## The recipe book data
var recipe_book_data : RecipeBookData = RecipeBookManager.get_recipe_book_data()
var tag_popup : PopupMenu

## contruct ui when scene is loaded
func _ready() -> void:
	init_recipe_book()

	## initialize dropdown with values from unit enum
	tag_popup = tag_selector.get_popup()
	tag_popup.hide_on_checkable_item_selection = false
	tag_popup.add_item("reset")
	for tag in GlobalTypes.get_tags_alphabetical():
		tag_popup.add_check_item(GlobalTypes.tag_to_text(tag), tag)
	tag_popup.connect("index_pressed", select_tag)

func init_recipe_book() -> void:
	recipe_book_data.recipes.sort_custom(func (a, b): return a.recipe_name < b.recipe_name)
	for recipe_data in recipe_book_data.recipes:
		var recipe_preview = recipe_preview_scene.instantiate()
		recipe_list.add_child(recipe_preview)
		recipe_preview.set_recipe(recipe_data)

func refresh() -> void:
	for child in recipe_list.get_children():
			child.queue_free()
	init_recipe_book()

func select_tag(index : int) -> void:
	if index == 0:
		for i in range(0,tag_popup.item_count):
			tag_popup.set_item_checked(i, false)
		return
	tag_popup.set_item_checked(index, not tag_popup.is_item_checked(index))

func _on_add_recipe_button_pressed() -> void:
	SceneManager.load_edit_recipe()


func _on_import_recipe_button_pressed() -> void:
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.popup_centered_ratio(1.0)



func _on_export_recipe_button_pressed() -> void:
	file_dialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
	file_dialog.set_current_dir(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS))
	file_dialog.set_current_file("recipe_export.json")
	file_dialog.popup_centered_ratio(1)

func _on_file_dialog_file_selected(path: String) -> void:
	# case export recipes
	if file_dialog.file_mode == FileDialog.FILE_MODE_SAVE_FILE:
		if selection_button.button_pressed:
			var partial_recipe_book_data = RecipeBookData.new()
			for child in recipe_list.get_children():
				if child.is_selected():
					partial_recipe_book_data.recipes.append(child.recipe_data)
			RecipeImporterExporter.export_to_json(partial_recipe_book_data, path)
		else:
			RecipeImporterExporter.export_to_json(recipe_book_data, path)
	# case import recipes
	elif file_dialog.file_mode == FileDialog.FILE_MODE_OPEN_FILE:
		var imported_data = RecipeImporterExporter.import_from_json(path)
		recipe_book_data.recipes.append_array(imported_data.recipes)
		RecipeBookManager.save_recipe_book_data()
		refresh()


func process_string(input : String) -> String:
	return input.to_lower().replace("-"," ").replace("(", " ").replace(")", " ").replace("/", " ")

func filter_recipes(filter_text : String, filter_tag_list : Array[GlobalTypes.Tag]) -> void:
	for recipe_preview in recipe_list.get_children():
		var recipe_data = recipe_preview.recipe_data
		var contains_search : bool = process_string(recipe_data.recipe_name).contains(filter_text)
		if filter_text == "":
			contains_search = true
		for ingredient in recipe_data.ingredients:
			if process_string(ingredient.ingredient_name).contains(filter_text):
				contains_search = true
		for tag in filter_tag_list:
			if not recipe_data.tags.has(tag):
				contains_search = false
		recipe_preview.visible = contains_search

func _on_apply_filter_button_pressed() -> void:
	var search_text_input := text_search_field.text
	search_text_input = process_string(search_text_input)
	var tag_list_input : Array[GlobalTypes.Tag] = []
	for i in range(0, tag_popup.item_count):
		if tag_popup.is_item_checked(i):
			tag_list_input.append(tag_popup.get_item_id(i))
	filter_recipes(search_text_input, tag_list_input)




func _on_clear_search_button_pressed():
	for recipe_preview in recipe_list.get_children():
		recipe_preview.show()
	for i in range(0,tag_popup.item_count):
			tag_popup.set_item_checked(i, false)
	text_search_field.text = ""


func _on_selection_button_toggled(button_pressed: bool) -> void:
	for child in recipe_list.get_children():
		child.show_selection_button(button_pressed)
	import_recipe_button.visible = not button_pressed
	add_recipe_button.visible = not button_pressed
	delete_recipes_button.visible = button_pressed



func _on_delete_recipes_button_pressed() -> void:
	if selection_button.button_pressed:
		for child in recipe_list.get_children():
			if child.is_selected():
				RecipeBookManager.delete_recipes([child.recipe_data])
		refresh()
