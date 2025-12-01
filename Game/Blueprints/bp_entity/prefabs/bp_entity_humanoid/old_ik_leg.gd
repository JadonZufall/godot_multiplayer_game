extends SkeletonIK3D

@export var foot_height_offset: float = 0.05
@export var interpolation_curve: Curve

@onready var ik_default: Node3D = $ik_default
@onready var ik_raycast: RayCast3D = $ik_raycast
@onready var ik_reference: BoneAttachment3D = $ik_reference

func _ready() -> void:
	start()

func _physics_process(_delta: float) -> void:
	ik_update_target_position()

func ik_update_target_position() -> void:
	var ik_target: Node3D = get_node(target_node)
	if ik_raycast.is_colliding():
		var collision_point: Vector3 = ik_raycast.get_collision_point()
		var collision_height: float = collision_point.y + foot_height_offset
		ik_target.global_transform.origin.y = collision_height
	else:
		ik_target.global_transform.origin.y = ik_default.global_transform.origin.y
