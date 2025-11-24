extends Label


func _process(_delta: float) -> void:
	if not PlayerHandler.current_entity:
		return
	text = "%f, %f, %f" % [PlayerHandler.current_entity.global_rotation.x, PlayerHandler.current_entity.global_rotation.y, PlayerHandler.current_entity.global_rotation.z]
