extends EntityDebugLabel


func _update(entity: Entity) -> void:
	text = "Speed: %fm/s" % entity.velocity.length()
