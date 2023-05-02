extends Control

## Class to manager recipe book ui components

@export var session_variables : SessionVariables
## UI scene for recipe preview
@onready var recipe_preview_scene : PackedScene = preload("res://scenes/recipe_preview.tscn")
@onready var file_dialog: FileDialog = %FileDialog
@onready var text_search_field: LineEdit = %TextSearchField
@onready var recipe_list: VBoxContainer = %RecipeList

## The recipe book data
var recipe_book_data : RecipeBookData = RecipeBookManager.get_recipe_book_data()


## contruct ui when scene is loaded
func _ready() -> void:
	## initialize list of previews for recipes stored on the recipe book
	recipe_book_data.recipes.sort_custom(func (a, b): return a.recipe_name < b.recipe_name)
	for recipe_data in recipe_book_data.recipes:
		var recipe_preview = recipe_preview_scene.instantiate()
		recipe_list.add_child(recipe_preview)
		recipe_preview.set_recipe(recipe_data)
	filter_recipes(session_variables.last_filter)
	text_search_field.text = session_variables.last_filter



func _on_add_recipe_button_pressed() -> void:
	SceneManager.load_edit_recipe()


func _on_import_recipe_button_pressed() -> void:
	pass # Replace with function body.


func _on_export_recipe_button_pressed() -> void:
	file_dialog.set_current_dir(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS))
	file_dialog.set_current_file("recipe_export.json")
	file_dialog.popup_centered_ratio(1)

func _on_file_dialog_file_selected(path: String) -> void:
	RecipeImporterExporter.export_to_json(recipe_book_data, path)

func process_string(input : String) -> String:
	return input.to_lower().replace("-"," ")

func filter_recipes(filter : String) -> void:
	for recipe_preview in recipe_list.get_children():
		var recipe_data = recipe_preview.recipe_data
		var contains_search : bool = process_string(recipe_data.recipe_name).contains(filter)
		if filter == "":
			contains_search = true
		for ingredient in recipe_data.ingredients:
			if process_string(ingredient.ingredient_name).contains(filter):
				contains_search = true
		recipe_preview.visible = contains_search

func _on_apply_filter_button_pressed() -> void:
	var search_text_input := text_search_field.text
	search_text_input = process_string(search_text_input)
	filter_recipes(search_text_input)
	session_variables.last_filter = search_text_input

