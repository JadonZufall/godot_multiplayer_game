class_name ActionRotate extends Action

@export var model: Node3D
@export var collider: CollisionShape3D
@export var rotation_speed: float = 5.0

func perform(delta: float) -> void:
	if not model:
		return
	var forward: Vector3 = -model.global_transform.basis.z                                          # Godot convention is that the local negative z-axis represents the forward direction
	var velocity: Vector3 = entity.get_real_velocity()
	
	var cur_direction = Vector2(forward.x, forward.z).normalized()
	var dst_direction = Vector2(velocity.x, velocity.z).normalized()
	
	var final_rot: float = cur_direction.angle_to(dst_direction)
	var delta_rot: float = lerp_angle(0.0, final_rot, rotation_speed * delta)
	
	#print(cur_direction.angle_to(dst_direction))
	
	# Prevents rotation jitter.
	if abs(final_rot) <= abs(delta_rot):
		delta_rot = final_rot
	
	# Apply Rotation
	model.rotate(Vector3.UP, delta_rot)
	collider.rotate(Vector3.UP, delta_rot)
	
	#print("____")
	#print(model.rotation)
	#print(dst_direction)
	#print(cur_direction)
	
	
	#print("final_rot=%f (%f)  |   delta_rot=%f (%f)" % [final_rot, rad_to_deg(final_rot), delta_rot, rad_to_deg(delta_rot)])
	
	collider.rotation = model.rotation
