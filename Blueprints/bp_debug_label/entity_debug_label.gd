@tool
class_name EntityDebugLabel extends Label3D

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	var parent: Node = get_parent()
	if parent is not Entity:
		warnings.append("This node must be a child of Entity")
	return warnings

func _process(delta: float) -> void:
	if get_parent() is not Entity:
		return
	var parent: Entity = get_parent() as Entity
	_update(parent)

func _update(entity: Entity) -> void:
	text = "ERROR: Override default _update() method on EntityDebugLabel"
