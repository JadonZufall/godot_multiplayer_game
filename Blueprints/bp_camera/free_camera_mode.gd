extends State


@onready var camera: Camera3D = $"../.."


func _update_physics(delta: float) -> void:
	camera.position += InputHandler.move_direction * camera.global_basis
