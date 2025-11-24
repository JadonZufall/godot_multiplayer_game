extends EntityDebugLabel


func _update(entity: Entity) -> void:
	if PlayerHandler.current_entity == entity:
		text = "POSSESSED"
	else:
		text = "?"
