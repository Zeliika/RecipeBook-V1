extends Resource
class_name IngredientData

## Class for holding data of an ingredient


## The name of the ingredient
@export var ingredient_name : String
## The base quantity of the ingredient
@export var base_quantity : float
## The unit used with the ingredient
@export var unit : GlobalTypes.Unit


## Initialize the ingredient with data on construction. Fills data with default values if no parameters are given
func _init(ingredient_name := "", base_quantity := 0.0, unit := GlobalTypes.Unit.NONE) -> void:
	self.ingredient_name = ingredient_name
	self.base_quantity = base_quantity
	self.unit = unit
