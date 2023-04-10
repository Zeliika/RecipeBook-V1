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


## Convert Unit value to unit short form
static func unit_to_label(unit : Unit) -> String:
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


## Convert Unit value to full word text
static func unit_to_text(unit : Unit) -> String:
	match (unit):
		Unit.MILLILITERS:
			return "Milliliter"
		Unit.GRAMS:
			return "Gramm"
		Unit.TEASPOON:
			return "Teelöffel"
		Unit.TABLESPOON:
			return "Esslöffel"
		Unit.NONE:
			return "ohne Einheit"
	## return empty string when unit is invalid
	return ""
