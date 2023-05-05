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
	PACKET = 5,
	BUNCH = 6,
	DROP = 7,
	PINCH = 8,

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
		Unit.PACKET:
			return "Pck"
		Unit.BUNCH:
			return "Bd"
		Unit.DROP:
			return "Tr"
		Unit.PINCH:
			return "Pr"

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
		Unit.PACKET:
			return "Päckchen"
		Unit.BUNCH:
			return "Bund"
		Unit.DROP:
			return "Tropfen"
		Unit.PINCH:
			return "Prise"
		Unit.NONE:
			return "ohne Einheit"

	## return empty string when unit is invalid
	return ""

static func tag_to_text(tag : Tag) -> String:
	match (tag):
		Tag.SAVOURY:
			return "herzhaft"
		Tag.SWEET:
			return "süß"
		Tag.SPICY:
			return "scharf"
		Tag.APPETIZER:
			return "Vorspeise"
		Tag.MAIN_DISH:
			return "Hauptspeise"
		Tag.DESSERT:
			return "Nachtisch"
		Tag.FINGERFOOD:
			return "Fingerfood"
		Tag.SALAD:
			return "Salat"
		Tag.BAKE:
			return "Auflauf"
		Tag.SNACKS:
			return "Knabberzeug"
		Tag.SWEETS:
			return "Süßigkeiten"
		Tag.VEGETARIAN:
			return "vegetarisch"
		Tag.VEGAN:
			return "vegan"
		Tag.LACTOSE_FREE:
			return "laktosefrei"
		Tag.FAST:
			return "schnell"
		Tag.EASY_TO_PREP:
			return "gut vorzubereiten"
		Tag.SOUP:
			return "Suppe"
		Tag.DIP:
			return "Dip"
		Tag.COOKIES:
			return "Kekse"
		Tag.CAKE:
			return "Kuchen/Torte"
		Tag.EXPERIMENTAL:
			return "experimentell"
		Tag.SAUCE:
			return "Soße"
	return "missing tag %s" %tag

static func get_tags_alphabetical() -> Array:
	var tags = Tag.values()
	tags.sort_custom(func(a, b) : return tag_to_text(a) < tag_to_text(b))
	return tags

enum Tag {
	SAVOURY = 0,
	SWEET = 1,
	SPICY = 2,
	APPETIZER = 3,
	MAIN_DISH = 4,
	DESSERT = 5,
	FINGERFOOD = 6,
	SALAD = 7,
	BAKE = 8,
	SNACKS = 9,
	SWEETS = 10,
	VEGETARIAN  = 11,
	VEGAN = 12,
	LACTOSE_FREE = 13,
	FAST = 14,
	EASY_TO_PREP = 15,
	SOUP = 16,
	DIP = 17,
	COOKIES = 18,
	CAKE = 19,
	EXPERIMENTAL = 20,
	SAUCE = 21,
}
