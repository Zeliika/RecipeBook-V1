extends Node
class_name RecipeImporterExporter

@export var recipe_book_data : RecipeBookData
const FILENAME = "res://recipe_book/recipes/recipes_test.json"


#func _ready() -> void:
#	import_from_json()

static func export_to_json(recipe_book_data : RecipeBookData) -> void:
	var json_result : String = JSON.stringify(RecipeBookManager.data_to_dictionary(), "\t", false)
	var file = FileAccess.open(FILENAME, FileAccess.WRITE)
	file.store_string(json_result)

static func import_from_json() -> RecipeBookData:
	var json := JSON.new()
	var text := FileAccess.open(FILENAME, FileAccess.READ).get_as_text()
	var parse_result := json.parse(text)
	return RecipeBookManager.dictionary_to_data(json.data)
