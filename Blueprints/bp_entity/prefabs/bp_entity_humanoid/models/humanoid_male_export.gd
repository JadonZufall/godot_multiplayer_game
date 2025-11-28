extends Node3D

@onready var animation_tree: AnimationTree = $animation_tree
@export var player: Entity

func _physics_process(delta: float) -> void:
	if not player: return
	animation_tree.set("parameters/blend_position", player.velocity.normalized())
