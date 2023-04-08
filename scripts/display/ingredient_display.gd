extends Node
class_name IngredientDisplay

## Class for constructing and managing the ui to display ingredients


## The quantity text field
@onready var quantity_text_field: LineEdit = $QuantityTextField
## The label displaying the unit
@onready var unit_label: Label = $UnitLabel
## The label displaying the name of the ingredient
@onready var name_label: Label = $NameLabel


## Initialize ingredient ui fields. Use default values if no parameter is given
func init(base_quantity:float = 0, unit:GlobalTypes.Unit = GlobalTypes.Unit.NONE, title:String = "") -> void:
	quantity_text_field.text = str(base_quantity)
	unit_label.text = GlobalTypes.unit_to_string(unit)
	name_label.text = title


## update the quantity text field
func set_quantity(new_quantity : float):
		quantity_text_field.text = str(new_quantity)


## Get access to quantity textfield
func get_quantity_text_field() -> LineEdit:
	return quantity_text_field
