extends Button

@onready var btn_start: Button = $"../../../../btn_start"


func _on_pressed() -> void:
	print("Start Server")
	NetworkHandler.start_server()
	btn_start.disabled = false
	get_parent().get_parent().visible = false
