class_name Entity extends CharacterBody3D



@export var camera_pivot: Node3D
@export var camera_spring: SpringArm3D
@export var camera_transform: Node3D

@export var _init_possessed: bool = false
@export var _auto_set_authority: bool = true
var components: Dictionary[String, Component] = {}
var actions: Dictionary[String, Action] = {}


@onready var synchronizer: MultiplayerSynchronizer = $synchronizer                                  # Required for multiplayer syncronization.


func _ready() -> void:
	if _init_possessed and multiplayer.is_server():
		PlayerHandler.possess_entity(self)
	
	elif not multiplayer.is_server():
		if name == str(multiplayer.get_unique_id()):
			PlayerHandler.possess_entity(self)
	

func configure_entity_authority(id: int) -> void:
	set_multiplayer_authority(id)

func _enter_tree() -> void:
	# TODO: Authority should always automatically be configured.
	if _auto_set_authority: call_deferred("configure_entity_authority", name.to_int())

func _physics_process(delta: float) -> void:
	# Only perform physics processing if this client is the multiplayer authority.
	if not is_multiplayer_authority(): return
	
	# Update every component.
	for key in components:
		components[key]._update(delta)
	
	# Detect collisions.
	var collision_detected: bool = move_and_slide()
	
	# Perform collision on prop.
	if collision_detected:
		for i in get_slide_collision_count():
			var collision: KinematicCollision3D = get_slide_collision(i)
			if collision.get_collider() is RigidBody3D:
				var body: Object = collision.get_collider()
				var normal = collision.get_normal()
				var push_vector = -normal
				body.apply_central_impulse(push_vector)


func _on_child_entered_tree(node: Node) -> void:
	if node is Component:
		components[node.name] = node
	if node is Action:
		actions[node.name] = node


func _on_child_exiting_tree(node: Node) -> void:
	if node is Component and components.has(node.name):
		components.erase(node.name)
	if node is Action and actions.has(node.name):
		actions.erase(node.name)
