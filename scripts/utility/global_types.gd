extends Resource
class_name GlobalTypes

## Global class for defining data types and their utility functions


## Units for ingredient quantities
enum Unit {
	NONE = 0,
	MILLILITERS = 1,
	GRAMS = 2,
	TEASPOON = 3,
	TABLESPOON = 4,
}


## Convert Unit value to readable string
static func unit_to_string(unit : Unit) -> String:
	match (unit):
		Unit.MILLILITERS:
			return "mL"
		Unit.GRAMS:
			return "g"
		Unit.TEASPOON:
			return "Tl"
		Unit.TABLESPOON:
			return "El"

	## return empty string when unit is NONE or invalid
	return ""
