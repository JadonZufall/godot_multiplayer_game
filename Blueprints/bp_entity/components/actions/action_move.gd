class_name ActionMove extends Action

@export var SPEED: float = 5.0

@onready var debug_ball: MeshInstance3D = $"../debug_ball"

func perform(delta: float) -> void:
	if not entity.is_on_floor():
		return
	
	if InputHandler.move_direction:
		var projected_direction: Vector3 = InputHandler.move_direction.normalized()
		
		debug_ball.position.x = projected_direction.x * 2
		debug_ball.position.y = 1
		debug_ball.position.z = projected_direction.z * 2
		
		entity.velocity.x = projected_direction.x * SPEED
		entity.velocity.z = projected_direction.z * SPEED
	else:
		entity.velocity.x = move_toward(entity.velocity.x, 0, SPEED)
		entity.velocity.z = move_toward(entity.velocity.z, 0, SPEED)
