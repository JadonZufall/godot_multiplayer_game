extends Button


func _on_pressed() -> void:
	print("Start Client")
	NetworkHandler.start_client()
	get_parent().get_parent().visible = false
