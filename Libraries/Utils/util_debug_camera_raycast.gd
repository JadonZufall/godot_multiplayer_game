extends RayCast3D

@onready var camera: Camera3D = $".."
@onready var rotate_debugger: MeshInstance3D = $"../rotate_debugger"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = event.position
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_direction = camera.project_ray_normal(mouse_pos)
		camera.look_at(ray_origin + ray_direction)
		rotate_debugger.look_at(ray_origin + ray_direction)
		
		if is_colliding():
			var collider = get_collider()
			var point = get_collision_point()
			var normal = get_collision_normal()
			print(collider)


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action_secondary"):
		var mouse_vel = Input.get_last_mouse_velocity()
		camera.rotate_y(-1 * mouse_vel.x * delta * 0.01)
		var rotation_x: float = -1 * mouse_vel.y * delta * 0.01 + camera.rotation.x
		camera.rotation.x = clamp(rotation_x, deg_to_rad(-80), deg_to_rad(80))
	
	
	
