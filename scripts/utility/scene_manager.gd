extends Node

@onready var root : Node = get_tree().get_root()
@onready var recipe_book_scene : PackedScene = preload("res://scenes/recipe_book_display.tscn")
@onready var recipe_scene : PackedScene = preload("res://scenes/recipe_display.tscn")
@onready var recipe_edit_scene : PackedScene = preload("res://scenes/recipe_edit_display.tscn")

func load_recipe_scene(recipe_data : RecipeData) -> void:
	clear()
	var recipe_display = recipe_scene.instantiate()
	root.add_child(recipe_display)
	recipe_display.init(recipe_data)

func load_main_menu() -> void:
	clear()
	root.add_child(recipe_book_scene.instantiate())

func load_edit_recipe(recipe_data: RecipeData) -> void:
	clear()
	var recipe_edit_display = recipe_edit_scene.instantiate()
	root.add_child(recipe_edit_display)
	recipe_edit_display.init(recipe_data)


func clear() -> void:
	for child in root.get_children():
		if child != self:
			child.queue_free()
