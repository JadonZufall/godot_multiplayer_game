extends Node

var input_direction: Vector2
var move_direction: Vector3


func _process(_delta: float) -> void:
	input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	if CameraHandler.current_camera:
		move_direction = Vector3(input_direction.x, 0.0, input_direction.y).rotated(Vector3.UP, CameraHandler.current_camera.global_rotation.y)
	elif PlayerHandler.current_entity:
		move_direction = Vector3(input_direction.x, 0.0, input_direction.y).rotated(Vector3.UP, PlayerHandler.current_entity.global_rotation.y)
	else:
		move_direction = Vector3(input_direction.x, 0.0, input_direction.y)
