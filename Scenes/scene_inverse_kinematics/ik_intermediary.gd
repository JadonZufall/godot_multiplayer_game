@tool
extends Marker3D

@export var ik_destination: Node3D
@export var initial_hip: Node3D
@export var initial_knee: Node3D
@export var initial_foot: Node3D

@export var theta_modifier: float = 45.0


func _process(delta: float) -> void:
	var thigh_length: float = initial_knee.position.length()
	var shin_length: float = initial_foot.position.length()
	var leg_length: float = thigh_length + shin_length
	
	var t_len: float = initial_foot.global_position.distance_to(ik_destination.global_position)
	#soh cah toa
	var rmod: float = deg_to_rad(theta_modifier)
	
	# Calculate angle of destination
	var theta: float = deg_to_rad(180) - (deg_to_rad(90) + (rmod / 2))
	var h: float = atan(theta) * (t_len / 2)
	position.y = h
	position.x = (ik_destination.position.x + initial_foot.position.x) / 2
	position.z = (ik_destination.position.z + initial_foot.position.z) / 2
