extends Control

class_name TagDisplay

@onready var tag_name_label: Label = %TagName

func init(tag_name : String) -> void:
	tag_name_label.text = tag_name
