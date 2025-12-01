class_name ActionTrigger extends Node

@export var only_possessed: bool = false
var _parent: Action

func update_parent() -> void:
	var parent: Node = get_parent()
	if parent is Action:
		_parent = parent as Action
	else:
		_parent = null

func _enter_tree() -> void:
	update_parent()

func _update(delta: float) -> void:
	if not _parent:
		push_warning("ActionTrigger has no parent.")
		return
	if only_possessed and PlayerHandler.current_entity != _parent.entity:
		return
	if check_trigger_condition(delta):
		_parent.perform(delta)

func check_trigger_condition(_delta: float) -> bool:
	return false
