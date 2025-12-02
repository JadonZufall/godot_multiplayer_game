extends Camera3D

@export var set_current_camera: bool = false


func _ready() -> void:
	CameraHandler.set_current_camera(self)
