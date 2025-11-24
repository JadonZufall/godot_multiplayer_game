extends EntityDebugLabel


func _update(entity: Entity) -> void:
	text = "Vel: (%f, %f, %f)" % [entity.velocity.x, entity.velocity.y, entity.velocity.z]
