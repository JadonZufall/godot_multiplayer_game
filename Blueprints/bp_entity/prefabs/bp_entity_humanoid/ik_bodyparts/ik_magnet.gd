@tool
class_name IKMagnet extends Marker3D

@export var override_magnet_position: bool = false

func _process(_delta: float) -> void:
	if not override_magnet_position:
		return
	if not get_parent() is SkeletonIK3D:
		return
	var parent: SkeletonIK3D = get_parent() as SkeletonIK3D
	parent.magnet = position

@export_tool_button("Copy Magnet Position", "Callable")
var copy_magnet_position_action: Callable = copy_magnet_position
func copy_magnet_position() -> void:
	if not get_parent() is SkeletonIK3D:
		push_error("Parent is not SkeletonIK3D")
		return
	var parent: SkeletonIK3D = get_parent() as SkeletonIK3D
	position = parent.magnet
