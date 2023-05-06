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

var recipe_book : RecipeBookDisplay

func get_recipe_book() -> RecipeBookDisplay:
	if recipe_book == null:
		recipe_book = get_node("/root/RecipeBookDisplay")
	return recipe_book

## Load the recipe display scene
func load_recipe_scene(recipe_data : RecipeData) -> void:
	clear()
	var recipe_display = recipe_scene.instantiate()
	root.add_child(recipe_display)
	recipe_display.init(recipe_data)



## Load the main recipe book scene
func load_main_menu() -> void:
	clear()
	get_recipe_book().show()
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
		if child != self and not child is RecipeBookManager and not child is RecipeBookDisplay: #TODO improve check
			child.queue_free()
	get_recipe_book().hide()


func correct_position(scene : Control) -> void:
	if is_mobile:
			scene.size = DisplayServer.get_display_safe_area().size
			scene.position = DisplayServer.get_display_safe_area().position
