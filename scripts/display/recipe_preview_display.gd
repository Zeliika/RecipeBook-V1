extends Control

## Class to manage recipe preview UI

@export var placeholder_image : Texture2D
@export var tag_display_scene : PackedScene
## The texture UI component
@onready var recipe_texture: TextureRect = %RecipeTexture
## The recipe name label
@onready var recipe_name_label: Label = %RecipeNameLabel
@onready var tag_preview_container: HFlowContainer = %TagPreviewContainer

## The data of the recipe to display
var recipe_data : RecipeData


## Initialize UI components with data from the recipe
func set_recipe(recipe_data: RecipeData) -> void:
	self.recipe_data = recipe_data
	recipe_texture.texture = placeholder_image if recipe_data.texture == null else recipe_data.texture
	recipe_name_label.text = recipe_data.recipe_name
	for tag in recipe_data.tags:
		var tag_display = tag_display_scene.instantiate()
		tag_preview_container.add_child(tag_display)
		tag_display.init(GlobalTypes.tag_to_text(tag))



## Load recipe scene if preview was clicked
func _on_pressed() -> void:
	SceneManager.load_recipe_scene(recipe_data)
