extends Node3D

@onready var animation_tree: AnimationTree = $animation_tree
@onready var player: Entity = $".."

func _physics_process(delta: float) -> void:
	if not player:
		push_warning("No Player To Animate")
		return
	animation_tree.set("parameters/conditions/idle", false)
	animation_tree.set("parameters/conditions/run", false)
