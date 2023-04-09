extends Node

@onready var root : Node = get_tree().get_root()
@onready var recipe_book_scene : PackedScene = preload("res://scenes/recipe_book_display.tscn")
@onready var recipe_scene : PackedScene = preload("res://scenes/recipe_display.tscn")

func load_recipe_scene(recipe_data : RecipeData) -> void:
	for child in root.get_children():
		if child != self:
			child.queue_free()
	var recipe_display = recipe_scene.instantiate()
	root.add_child(recipe_display)
	recipe_display.init(recipe_data)

func load_main_menu() -> void:
	for child in root.get_children():
		if child != self:
			child.queue_free()
	root.add_child(recipe_book_scene.instantiate())
