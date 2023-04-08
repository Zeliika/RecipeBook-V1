extends Node
class_name RecipeDisplay


## The label displaying the recipe title
@onready var title_label: Label = $TitleLabel
## The container holding the ingredient ui components
@onready var ingredient_list_container: VBoxContainer = $IngredientListContainer

## the scene file for displaying ingredients
var ingredient_display_scene : PackedScene = preload("res://scenes/ingredient_display.tscn")

## the data of the recipe that is displayed
var recipe_data : RecipeData


## initialize recipe ui and fill fields with relevant data
func init(recipe_data : RecipeData) -> void:
	self.recipe_data = recipe_data
	title_label.text = recipe_data.recipe_name

	## initialize ingredient list
	for ingredient in recipe_data.ingredients:
		var display = ingredient_display_scene.instantiate()
		display.init(ingredient.base_quantity,ingredient.unit, ingredient.title)
		ingredient_list_container.add_child(display)
		display.get_quantity_text_field.text_submitted.connect(calc_quantity.bind(display.get_index()))


## calculate new quantity for all ingredients based on their base ratios when user enters
## new quantity for an ingredient
func calc_quantity(new_quantity, ingredient_index) -> void:
	new_quantity = float(new_quantity)
	var factor = new_quantity/recipe_data.ingredients[ingredient_index].base_quantity
	for i in range(0, ingredient_list_container.get_child_count()):
		ingredient_list_container.get_child(i).set_quantity(recipe_data.ingredients[i].base_quantityfactor)


## return to recipe list when return button is pressed
func _on_return_to_menu_pressed() -> void:
	pass
