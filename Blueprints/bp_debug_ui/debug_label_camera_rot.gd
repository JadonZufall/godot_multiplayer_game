extends Label



func _process(_delta: float) -> void:
	var camera: Camera3D = CameraHandler.current_camera
	if not camera: return
	text = "%f, %f, %f" % [camera.global_rotation.x, camera.global_rotation.y, camera.global_rotation.z]
