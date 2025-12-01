class_name ActionTriggerKeyPress extends ActionTrigger

@export var action: StringName

func check_trigger_condition(delta: float) -> bool:
	return Input.is_action_just_pressed(action)
