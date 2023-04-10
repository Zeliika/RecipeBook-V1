extends Control

@onready var title_edit: LineEdit = $TitleEdit
@onready var description_edit: TextEdit = $Description
@onready var ingredient_list_container: VBoxContainer = $Container/IngredientListContainer

var recipe_data : RecipeData
var ingredient_edit_display_scene : PackedScene = preload("res://scenes/ingredient_edit_display.tscn")

func init(recipe_data : RecipeData = null) -> void:
	self.recipe_data = recipe_data

	if recipe_data == null:
		return

	title_edit.text = recipe_data.recipe_name

	for ingredient in recipe_data.ingredients:
		var display = ingredient_edit_display_scene.instantiate()
		ingredient_list_container.add_child(display)
		display.init(ingredient)

	description_edit.text = recipe_data.description



func _on_reset_button_pressed() -> void:
	SceneManager.load_edit_recipe(recipe_data)


func _on_cancel_button_pressed() -> void:
	SceneManager.load_recipe_scene(recipe_data)


func _on_save_button_pressed() -> void:
	var recipe_name := title_edit.text
	var ingredient_list : Array[IngredientData] = []
	for ingredient_edit_display in ingredient_list_container.get_children():
		ingredient_list.append(ingredient_edit_display.get_ingredient_data())
	var description := description_edit.text

	if recipe_data == null:
		recipe_data = RecipeData.new() #TODO add recipe to recipe book
	recipe_data.recipe_name = recipe_name
	recipe_data.ingredients = ingredient_list
	recipe_data.description = description
	SceneManager.load_recipe_scene(recipe_data)
#TODO save recipe book

