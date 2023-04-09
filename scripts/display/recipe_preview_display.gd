extends Control

@onready var recipe_texture: TextureRect = $Container/RecipeTexture
@onready var recipe_name: Label = $Container/RecipeName

var recipe_data : RecipeData

func set_recipe(recipe_data: RecipeData) -> void:
	self.recipe_data = recipe_data
	recipe_texture.texture = recipe_data.texture
	recipe_name.text = recipe_data.recipe_name


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		SceneManager.load_recipe_scene(recipe_data)
