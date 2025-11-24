extends Node

const DEBUG_LAYER: int = 20

func toggle_debug_layer() -> void:
	CameraHandler.current_camera.cull_mask ^= 1 << (DEBUG_LAYER - 1)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_quit"):
		print("debug_quit")
		NetworkHandler.quit_all_clients.rpc()
		get_tree().quit()
	
	if Input.is_action_just_pressed("debug_toggle_mouse_lock"):
		print("debug_toggle_mouse_lock")
		MouseHandler.toggle_capture_mouse()
	
	if Input.is_action_just_pressed("debug_toggle_show_layer"):
		print("debug_toggle_show_layer")
		toggle_debug_layer()
