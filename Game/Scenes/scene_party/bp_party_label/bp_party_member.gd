extends Control

@export var label_username: Label

func _enter_tree() -> void:
	call_deferred("set_username")

func set_username() -> void:
	label_username.text = name
