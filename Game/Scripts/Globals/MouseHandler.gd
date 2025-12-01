extends Node


var sensitivity: float = 1.0
var look_delta: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if CameraHandler.current_camera:
		CameraHandler.current_camera


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		look_delta += Vector2(event.relative.x, event.relative.y)

func toggle_capture_mouse() -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		print("Captured Mouse")
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		look_delta = Vector2.ZERO
	else:
		print("Freed Mouse")
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		look_delta = Vector2.ZERO
