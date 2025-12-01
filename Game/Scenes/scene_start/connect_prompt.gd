extends Control



@export var btn_join: Button
@export var btn_host: Button
@export var btn_public: CheckButton
@export var input_addr: LineEdit
@export var input_port: LineEdit

@export var btn_start: Button
@export var scene_party: Control


func _on_btn_host_pressed() -> void:
	print("Start Server")
	NetworkHandler.start_server()
	btn_start.disabled = false
	visible = false
	scene_party.visible = true

func _on_btn_join_pressed() -> void:
	print("Start Client")
	NetworkHandler.start_client()
	visible = false
	scene_party.visible = true
	

func _on_btn_public_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
