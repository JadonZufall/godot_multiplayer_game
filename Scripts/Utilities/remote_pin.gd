@tool
class_name RemotePin extends Node

@export var target: Node3D
@export var is_global: bool = true

@export_category("Position")
@export var pin_x_position: bool = false
@export var pin_y_position: bool = false
@export var pin_z_position: bool = false

@export_category("Rotation")
@export var pin_x_rotation: bool = false
@export var pin_y_rotation: bool = false
@export var pin_z_rotation: bool = false

@export_category("Scale")
@export var pin_x_scale: bool = false
@export var pin_y_scale: bool = false
@export var pin_z_scale: bool = false

func _process(_delta: float) -> void:
	if not target:
		return
	if not get_parent() is Node3D:
		return
	var parent: Node3D = get_parent() as Node3D
	if pin_x_position:
		if is_global:
			if parent.is_inside_tree() and target.is_inside_tree():
				parent.global_position.x = target.global_position.x
		else:
			parent.position.x = target.position.x
	if pin_y_position:
		if is_global:
			if parent.is_inside_tree() and target.is_inside_tree():
				parent.global_position.y = target.global_position.y
		else:
			parent.position.y = target.position.y
	if pin_z_position:
		if is_global:
			if parent.is_inside_tree() and target.is_inside_tree():
				parent.global_position.z = target.global_position.z
		else:
			parent.position.z = target.position.z
	if pin_x_rotation or pin_y_rotation or pin_z_rotation:
		push_warning("TODO: Write pin for rotation")
	if pin_x_scale or pin_y_scale or pin_z_scale:
		push_warning("TODO: Write pin for scale")
