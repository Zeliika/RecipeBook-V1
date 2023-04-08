extends Node
class_name RecipeImporter

@export var recipe_book_data : RecipeBookData

#func _ready() -> void:
#	import_from_json()


func import_from_json() -> void:
	var json := JSON.new()
	var text := FileAccess.open("res://recipe_book/recipes/recipes_test.json", FileAccess.READ).get_as_text()
	var parse_result := json.parse(text)

	if not parse_result == OK:
		return

	var data = json.get_data()

	for recipe in data["recipes"]:
		var ingredients :Array[IngredientData] = []
		for ingredient in recipe["ingredients"]:
			var ingredient_data = IngredientData.new(ingredient["name"], ingredient["quantity"], ingredient["unit"])
			ingredients.append(ingredient_data)

		var recipe_data = RecipeData.new(recipe["name"], ingredients)
		recipe_book_data.recipes.append(recipe_data)

	ResourceSaver.save(recipe_book_data,"res://recipe_book/import_recipe_book_test.tres" )


