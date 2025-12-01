class_name Action extends Component

func _update(delta: float) -> void:
	for child in get_children():
		if not child is ActionTrigger:
			continue
		child._update(delta)

func perform(delta: float) -> void:
	pass
