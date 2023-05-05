extends Node

var recipe_book_data : RecipeBookData = null

func get_recipe_book_data() -> RecipeBookData:
	if recipe_book_data == null:
		recipe_book_data = RecipeImporterExporter.import_from_json()
	return recipe_book_data

func save_recipe_book_data() -> void:
	RecipeImporterExporter.export_to_json(recipe_book_data)

func add_recipe(recipe_data : RecipeData, do_save : bool = false) -> void:
	recipe_book_data.recipes.append(recipe_data)
	if do_save:
		save_recipe_book_data()

func data_to_dictionary() -> Dictionary:
	var recipe_book_dictionary : Dictionary = {}
	var recipes : Array[Dictionary] = []

	for recipe_data in recipe_book_data.recipes:
		var recipe_dictionary : Dictionary = {}
		recipe_dictionary["name"] = recipe_data.recipe_name
		recipe_dictionary["tags"] = recipe_data.tags
		recipe_dictionary["description"] = recipe_data.description
		var ingredients : Array[Dictionary] = []

		for ingredient_data in recipe_data.ingredients:
			var ingredient_dictionary : Dictionary = {}
			ingredient_dictionary["name"] = ingredient_data.ingredient_name
			ingredient_dictionary["unit"] = ingredient_data.unit
			ingredient_dictionary["quantity"] = ingredient_data.base_quantity
			ingredients.append(ingredient_dictionary)

		recipe_dictionary["ingredients"] = ingredients
		recipes.append(recipe_dictionary)

	recipe_book_dictionary["recipes"] = recipes
	return recipe_book_dictionary


func dictionary_to_data(recipe_book_dictionary : Dictionary) -> RecipeBookData:
	var recipe_book_data : RecipeBookData = RecipeBookData.new()
	var recipes : Array[RecipeData] = []

	for recipe_dictionary in recipe_book_dictionary["recipes"]:
		var recipe_data : RecipeData = RecipeData.new()
		if recipe_dictionary.has("name"):
			recipe_data.recipe_name = recipe_dictionary["name"]
		if recipe_dictionary.has("tags"):
			recipe_data.tags = recipe_dictionary["tags"]
		if recipe_dictionary.has("description"):
			recipe_data.description = recipe_dictionary["description"]
		var ingredients : Array[IngredientData] = []

		for ingredient_dictionary in recipe_dictionary["ingredients"]:
			var ingredient_data : IngredientData = IngredientData.new()
			ingredient_data.ingredient_name = ingredient_dictionary["name"]
			ingredient_data.unit = ingredient_dictionary["unit"]
			ingredient_data.base_quantity = ingredient_dictionary["quantity"]
			ingredients.append(ingredient_data)

		recipe_data.ingredients = ingredients
		recipes.append(recipe_data)

	recipe_book_data.recipes = recipes
	return recipe_book_data
