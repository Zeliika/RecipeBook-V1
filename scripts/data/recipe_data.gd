extends Resource
class_name RecipeData

## Class to store and manage recipe data

## The name of the recipe
@export var recipe_name : String
## The list of ingredients
@export var ingredients : Array[IngredientData]
## An image displaying the recipe result.
@export var texture : Texture2D = preload("res://icon.svg")


## Initialize a new recipe data with values. Uses default values when no parameters are given
func _init(recipe_name: String = "", ingredients: Array[IngredientData] = [], texture: Texture2D = preload("res://icon.svg")) -> void:
	self.recipe_name = recipe_name
	self.ingredients = ingredients
	self.texture = texture
