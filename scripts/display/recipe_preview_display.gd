extends Control

## Class to manage recipe preview UI


## The texture UI component
@onready var recipe_texture: TextureRect = $Container/RecipeTexture
## The recipe name label
@onready var recipe_name: Label = $Container/RecipeName

## The data of the recipe to display
var recipe_data : RecipeData

## Initialize UI components with data from the recipe
func set_recipe(recipe_data: RecipeData) -> void:
	self.recipe_data = recipe_data
	recipe_texture.texture = recipe_data.texture
	recipe_name.text = recipe_data.recipe_name


## Load recipe scene if preview was clicked
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		SceneManager.load_recipe_scene(recipe_data)
