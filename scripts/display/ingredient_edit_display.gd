extends HBoxContainer

## Class to control ingredient edit ui

signal ingredient_selected(index : int, selected : bool)

## The text field for quantity
@onready var quantity_text_field: LineEdit = %QuantityTextField
## The dropdown for unit selection
@onready var unit_dropdown: OptionButton = %UnitDropdown
## The text field containing the ingredient name
@onready var name_edit: LineEdit = %NameLabel
@onready var check_button: CheckButton = %CheckButton


func _ready() -> void:
	## initialize dropdown with values from unit enum
	for unit in GlobalTypes.Unit.values():
		unit_dropdown.add_item(GlobalTypes.unit_to_text(unit), unit)


## Initialize gui fields with data from ingredient
func init(ingredient_data : IngredientData = null) -> void:
	if ingredient_data == null:
		return
	quantity_text_field.text = str(ingredient_data.base_quantity)
	unit_dropdown.select(ingredient_data.unit)
	name_edit.text = ingredient_data.ingredient_name


## Contruct and return new ingredient from ui field inputs
func get_ingredient_data() -> IngredientData:
	var ingredient_data = IngredientData.new()
	ingredient_data.base_quantity = float(quantity_text_field.text) #TODO catch case of invalid input
	ingredient_data.unit = unit_dropdown.get_selected_id()
	ingredient_data.ingredient_name = name_edit.text
	return ingredient_data

func get_button() -> Button:
	return %Button

## TODO Replace with drag and drop behaviour
func deselect_ingredient() -> void:
	check_button.button_pressed = false

## TODO Replace with drag and drop behaviour
func _on_check_button_toggled(button_pressed: bool) -> void:
	emit_signal("ingredient_selected", get_index(), button_pressed)
