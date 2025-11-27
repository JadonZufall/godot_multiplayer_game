@tool
extends Button

@export var camera: Camera3D
@export var pivot: Node3D

func _on_pressed() -> void:
	pivot.rotate_y(deg_to_rad(-90))
