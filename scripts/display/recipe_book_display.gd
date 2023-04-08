extends Control

## Class to manager recipe book ui components

## UI scene for recipe preview
@onready var recipe_preview_scene = preload("res://scenes/recipe_preview.tscn")
## The recipe book data
@export var recipe_book_data : RecipeBookData


## contruct ui when scene is loaded
func _ready() -> void:
	## initialize list of previews for recipes stored on the recipe book
	for recipe_data in recipe_book_data.recipes:
		var recipe_preview = recipe_preview_scene.instantiate()
		$RecipeList.add_child(recipe_preview)
		recipe_preview.set_recipe(recipe_data)
