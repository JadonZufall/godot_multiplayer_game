@tool
extends Marker3D

@export var is_active: bool = false

var _reset_toggle: bool = false

var _last_position: Vector3 = Vector3.ZERO
var _applied_position_offset: Vector3 = Vector3.ZERO

var _last_rotation: Vector3 = Vector3.ZERO
var _applied_rotation_offset: Vector3 = Vector3.ZERO

@export var ik_skeleton: IKBodyPart

@export_tool_button("Reset IK Target", "Callable")
var reset_ik_target_action: Callable = reset_ik_target
func reset_ik_target() -> void:
	if not ik_skeleton:
		push_error("No IK Skeleton")
		return
	ik_skeleton.restore_default()

@export_group("Transform Scale")
@export var position_scale: float = 1.0
@export var rotation_scale: float = 1.0


func get_delta_position(ik_default: Node3D, ik_target: Node3D) -> Vector3:
	return (position - _last_position) * position_scale

func get_delta_rotation(ik_default: Node3D, ik_target: Node3D) -> Vector3:
	return (rotation - _last_rotation) * rotation_scale

func on_control_enabled(ik_default: Node3D, ik_target: Node3D) -> void:
	# Apply the offset back to the target
	_applied_position_offset = Vector3.ZERO
	_last_position = position
	
	_applied_rotation_offset = Vector3.ZERO
	_last_rotation = rotation
	
	_reset_toggle = true
	print("Enabled control %s" % name)

func on_control_disabled(ik_default: Node3D, ik_target: Node3D) -> void:
	# Remove the offset applied to the target
	ik_target.position -= _applied_position_offset
	_applied_position_offset = Vector3.ZERO
	
	ik_target.position -= _applied_rotation_offset
	_applied_rotation_offset = Vector3.ZERO
	
	_reset_toggle = false
	print("Disabled control %s" % name)

func _process(_delta: float) -> void:
	if not ik_skeleton:
		return
	
	var ik_default: Node3D = ik_skeleton.get_node("ik_default")
	if not ik_default:
		push_error("Unable to find ik_default")
		return
	
	var ik_target: Node3D = ik_skeleton.get_node(ik_skeleton.target_node)
	if not ik_target:
		push_error("Unable to find ik_target")
		return
	
	if is_active != _reset_toggle:
		if is_active:
			on_control_enabled(ik_default, ik_target)
		else:
			on_control_disabled(ik_default, ik_target)
	
	if not is_active:
		return
	
	var delta_position: Vector3 = get_delta_position(ik_default, ik_target)
	ik_target.position += delta_position
	_applied_position_offset += delta_position
	_last_position = position
	
	var delta_rotation: Vector3 = get_delta_rotation(ik_default, ik_target)
	ik_target.rotation += delta_rotation
	_applied_rotation_offset += delta_rotation
	_last_rotation = rotation
	
	
	
