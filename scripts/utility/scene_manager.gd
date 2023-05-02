extends Node

## Class to lmanage switching between scenes


## The root node of the scene tree
@onready var root : Node = get_tree().get_root()
## The recipe book scene
@onready var recipe_book_scene : PackedScene = preload("res://scenes/recipe_book_display.tscn")
## The recipe scene
@onready var recipe_scene : PackedScene = preload("res://scenes/recipe_display.tscn")
## The recipe edit scene
@onready var recipe_edit_scene : PackedScene = preload("res://scenes/recipe_edit_display.tscn")

@onready var is_mobile := false


#func _ready() -> void:
#	is_mobile = OS.get_name() == "Android"


## Load the recipe display scene
func load_recipe_scene(recipe_data : RecipeData) -> void:
	clear()
	var recipe_display = recipe_scene.instantiate()
	root.add_child(recipe_display)
	recipe_display.init(recipe_data)
#	correct_position(recipe_display)


## Load the main recipe book scene
func load_main_menu() -> void:
	clear()
	var scene = recipe_book_scene.instantiate()
	root.add_child(scene)
#	correct_position(scene)

## Load the recipe edit scene. Pass null if new recipe is added
func load_edit_recipe(recipe_data: RecipeData = null) -> void:
	clear()
	var recipe_edit_display = recipe_edit_scene.instantiate()
	root.add_child(recipe_edit_display)
	recipe_edit_display.init(recipe_data)
#	correct_position(recipe_edit_display)


## Clear all other scenes before loading new ones
func clear() -> void:
	for child in root.get_children():
		## Only delete scene if it is not the scene manager
		if child != self and not child is RecipeBookManager: #TODO improve check
			child.queue_free()


func correct_position(scene : Control) -> void:
	if is_mobile:
			scene.size = DisplayServer.get_display_safe_area().size
			scene.position = DisplayServer.get_display_safe_area().position
