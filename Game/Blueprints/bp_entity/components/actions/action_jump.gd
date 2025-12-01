class_name ActionJump extends Action

@export var JUMP_VELOCITY: float = 4.5

func perform(delta: float) -> void:
	# Ignore function call if entity is airborn.
	if not entity.is_on_floor():
		return
	
	entity.velocity.y = JUMP_VELOCITY
