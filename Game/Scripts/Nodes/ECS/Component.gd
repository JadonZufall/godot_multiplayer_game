@icon("uid://b85jy7psfa7km")
class_name Component extends Node

var entity: Entity

func _find_entity() -> Entity:
	var parent: Node = get_parent()
	while parent is not Entity:
		parent = get_parent()
		if not parent:
			push_error("_find_entity failed to find parent entity")
			return null
	return parent

func _ready() -> void:
	entity = _find_entity()

func _process_update(_delta: float) -> void:
	pass

func _physics_update(_delta: float) -> void:
	pass

func _process_update_authority(_delta: float) -> void:
	pass

func _physics_update_authority(_delta: float) -> void:
	pass
