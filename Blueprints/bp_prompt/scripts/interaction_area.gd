extends Area3D

signal current_camera_entered_area(camera: Camera3D)
signal current_camera_exited_area(camera: Camera3D)

@onready var collider: CollisionShape3D = $collider

@export var max_interaction_distance: float = 5.0
@export var min_interaction_distance: float = 1.0

var is_camera_in_bounds: bool = false

func _ready() -> void:
	var camera: Camera3D = get_viewport().get_camera_3d()
	var distance: float = global_position.distance_to(camera.global_position)
	is_camera_in_bounds = distance <= max_interaction_distance
	
	var shape: SphereShape3D = collider.shape as SphereShape3D
	shape.radius = max_interaction_distance

func body_entered(body: Node3D) -> void:
	if is_camera_in_bounds:
		return
	var camera: Camera3D = get_viewport().get_camera_3d()
	var distance: float = global_position.distance_to(camera.global_position)
	if distance > max_interaction_distance:
		return
	is_camera_in_bounds = true
	current_camera_entered_area.emit(camera)

func body_exited(body: Node3D) -> void:
	if not is_camera_in_bounds:
		return
	var camera: Camera3D = get_viewport().get_camera_3d()
	var distance: float = global_position.distance_to(camera.global_position)
	if distance <= max_interaction_distance:
		return
	current_camera_exited_area.emit(camera)
