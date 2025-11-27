@tool
extends CheckButton

@export var grid: MeshInstance3D

func _on_toggled(toggled_on: bool) -> void:
	grid.visible = toggled_on
