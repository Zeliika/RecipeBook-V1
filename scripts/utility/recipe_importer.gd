extends Node
class_name RecipeImporterExporter

@export var recipe_book_data : RecipeBookData
const FILENAME = "user://recipes.json"


static func export_to_json(recipe_book_data : RecipeBookData, save_path : String = FILENAME) -> void:
	var json_result : String = JSON.stringify(RecipeBookManager.data_to_dictionary(), "\t", false)
	var file = FileAccess.open(save_path, FileAccess.WRITE_READ)
	file.store_string(json_result)

static func import_from_json() -> RecipeBookData:
	var json := JSON.new()
	if not FileAccess.file_exists(FILENAME):
		return RecipeBookData.new()
	var text := FileAccess.open(FILENAME, FileAccess.READ).get_as_text()
	var parse_result := json.parse(text)
	print(parse_result)
	if parse_result == Error.OK:
		return RecipeBookManager.dictionary_to_data(json.data)

	return RecipeBookData.new()
