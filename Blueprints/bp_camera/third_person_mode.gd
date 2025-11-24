extends State

@onready var camera: Camera3D = $"../.."
@export var tilt_limit: float = deg_to_rad(75)


func _update_physics(delta: float) -> void:
	if not PlayerHandler.current_entity or PlayerHandler.current_entity is not Entity:
		return
	
	var entity: Entity = PlayerHandler.current_entity as Entity
	camera.position = entity.camera_transform.global_position
	camera.rotation = entity.camera_transform.global_rotation
	
	
	entity.camera_pivot.rotation.x -= MouseHandler.look_delta.y * MouseHandler.sensitivity * delta
	entity.camera_pivot.rotation.x = clampf(entity.camera_pivot.rotation.x, -tilt_limit, tilt_limit)
	entity.camera_pivot.rotation.y += -1 * MouseHandler.look_delta.x * MouseHandler.sensitivity * delta
	MouseHandler.look_delta = Vector2.ZERO
