extends Label


func _process(delta: float) -> void:
	text = "%d" % multiplayer.get_unique_id()
