@tool
class_name TransformationLock extends Node

@export var is_enabled: bool = false
@export var is_global: bool = false
@export_group("Position")
@export var do_position: bool = false
@export var locked_position: Vector3 = Vector3.ZERO
@export_group("Rotation")
@export var do_rotation: bool = false
@export var locked_rotation: Vector3 = Vector3.ZERO
@export_group("Scale")
@export var do_scale: bool = false
@export var locked_scale: Vector3 = Vector3.ONE

func _process(_delta: float) -> void:
	if not is_inside_tree() or is_enabled or not get_parent() is Node3D:
		return
	var parent: Node3D = get_parent() as Node3D
	if is_global:
		if do_position:
			parent.global_position = locked_position
		if do_rotation:
			parent.global_rotation = locked_rotation
	else:
		if do_position:
			parent.position = locked_position
		if do_rotation:
			parent.rotation = locked_rotation
	if do_scale:
		parent.scale = locked_scale
	
