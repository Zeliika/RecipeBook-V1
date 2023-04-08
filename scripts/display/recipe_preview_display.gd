extends HBoxContainer

@onready var recipe_texture: TextureRect = $RecipeTexture
@onready var recipe_name: Label = $RecipeName

var recipe_data : RecipeData

func set_recipe(recipe_data: RecipeData) -> void:
	self.recipe_data = recipe_data
	recipe_texture.texture = recipe_data.texture
	recipe_name.text = recipe_data.recipe_name
