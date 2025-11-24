extends Node

signal on_current_camera_set


var current_camera: Camera3D = null
var current_target: Node3D = null


func set_current_camera(camera: Camera3D) -> void:
	if current_camera != null:
		push_warning("Overriding current_camera")
	current_camera = camera
