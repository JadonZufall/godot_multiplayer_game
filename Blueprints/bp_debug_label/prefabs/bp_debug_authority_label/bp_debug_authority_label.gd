extends EntityDebugLabel

func _update(entity: Entity) -> void:
	if entity.is_multiplayer_authority():
		text = "*%d" % entity.get_multiplayer_authority()
	else:
		text = "%d" % entity.get_multiplayer_authority()
