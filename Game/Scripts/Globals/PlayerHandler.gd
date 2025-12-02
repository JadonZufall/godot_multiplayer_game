extends Node


signal on_entity_possessed(entity: Entity)

var current_entity: Entity = null
func possess_entity(entity: Entity) -> void:
	current_entity = entity
