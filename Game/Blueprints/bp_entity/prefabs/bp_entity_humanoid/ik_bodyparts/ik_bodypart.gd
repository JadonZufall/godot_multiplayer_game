@tool
class_name IKBodyPart extends SkeletonIK3D

func restore_default() -> void:
	restore_default_position()
	restore_default_rotation()
@export_tool_button("Restore Default", "Callable")
var restore_default_action: Callable = restore_default

@export_group("Setup")
func setup_reference_bones() -> void:
	var parent: Skeleton3D = get_parent_skeleton()
	
	var ik_reference_root: BoneAttachment3D = get_node("ik_reference_root")
	ik_reference_root.override_pose = false
	ik_reference_root.set_use_external_skeleton(true)
	if parent:
		ik_reference_root.set_external_skeleton(parent.get_path())
	ik_reference_root.bone_name = root_bone
	
	var ik_reference_tip: BoneAttachment3D = get_node("ik_reference_tip")
	ik_reference_tip.override_pose = false
	ik_reference_tip.set_use_external_skeleton(true)
	if parent:
		ik_reference_tip.set_external_skeleton(parent.get_path())
	ik_reference_tip.bone_name = tip_bone

@export_tool_button("Setup Reference Bones", "Callable")
var setup_reference_bones_action: Callable = setup_reference_bones

@export_group("Default")
func restore_default_position() -> void:
	var ik_target: Node3D = get_node(target_node)
	if not ik_target:
		push_error("Unable to locate target node")
		return
	ik_target.global_position = get_node("ik_default").global_position

@export_tool_button("Restore Default Position", "Callable")
var restore_initial_default_action: Callable = restore_default_position

func restore_default_rotation() -> void:
	var ik_target: Node3D = get_node(target_node)
	if not ik_target:
		push_error("Unable to locate target node")
		return
	ik_target.global_rotation = get_node("ik_default").global_rotation

@export_tool_button("Restore Default Rotation", "Callable")
var restore_default_rotation_action: Callable = restore_default_rotation


@export_group("Initial")
func restore_initial_position() -> void:
	var ik_target: Node3D = get_node(target_node)
	if not ik_target:
		push_error("Unable to locate target node")
		return
	ik_target.global_position = get_node("ik_initial").global_position

@export_tool_button("Restore Initial Position", "Callable")
var restore_initial_position_action: Callable = restore_initial_position


func restore_initial_rotation() -> void:
	var ik_target: Node3D = get_node(target_node)
	if not ik_target:
		push_error("Unable to locate target node")
		return
	ik_target.global_rotation = get_node("ik_initial").global_rotation

@export_tool_button("Restore Initial Rotation", "Callable")
var restore_initial_rotation_action: Callable = restore_initial_rotation

@export_group("Reset")
func reset_target_rotation() -> void:
	var ik_target: Node3D = get_node(target_node)
	if not ik_target:
		push_error("Unable to locate target node")
		return
	ik_target.global_rotation = Vector3.ZERO
@export_tool_button("Reset Target Rotation", "Callable")
var reset_target_rotation_action: Callable = reset_target_rotation
