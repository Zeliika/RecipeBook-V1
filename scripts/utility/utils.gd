extends Resource

class_name Utils

static func compare_alphabetically(a : String, b : String) -> bool:
	return process_string(a) < process_string(b)

static func process_string(input : String) -> String:
	return input.to_lower() \
			.replace("-", " ") \
			.replace("ä", "ae") \
			.replace("ö", "oe") \
			.replace("ü", "ue") \
