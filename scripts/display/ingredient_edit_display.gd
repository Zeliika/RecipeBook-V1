extends HBoxContainer

@onready var quantity_text_field: LineEdit = $QuantityTextField
@onready var unit_dropdown: OptionButton = $UnitDropdown
@onready var name_label: LineEdit = $NameLabel

func _ready() -> void:
	for unit in GlobalTypes.Unit.values():
		unit_dropdown.add_item(GlobalTypes.unit_to_text(unit), unit)

func init(ingredient_data : IngredientData) -> void:
	quantity_text_field.text = str(ingredient_data.base_quantity)
	unit_dropdown.select(ingredient_data.unit)
	name_label.text = ingredient_data.ingredient_name

func get_ingredient_data() -> IngredientData:
	var ingredient_data = IngredientData.new()
	ingredient_data.base_quantity = float(quantity_text_field.text) #TODO catch case of invalid input
	ingredient_data.unit = unit_dropdown.get_selected_id()
	ingredient_data.ingredient_name = name_label.text
	return ingredient_data
