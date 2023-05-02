extends Control

## Class to manager recipe book ui components

## UI scene for recipe preview
@onready var recipe_preview_scene : PackedScene = preload("res://scenes/recipe_preview.tscn")
@onready var file_dialog: FileDialog = $FileDialog

## The recipe book data
var recipe_book_data : RecipeBookData = RecipeBookManager.get_recipe_book_data()


## contruct ui when scene is loaded
func _ready() -> void:
#	size = DisplayServer.get_display_safe_area().size
#	position = DisplayServer.get_display_safe_area().position
	## initialize list of previews for recipes stored on the recipe book
	for recipe_data in recipe_book_data.recipes:
		var recipe_preview = recipe_preview_scene.instantiate()
		%RecipeList.add_child(recipe_preview)
		recipe_preview.set_recipe(recipe_data)



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

