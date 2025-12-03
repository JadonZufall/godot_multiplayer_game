@icon("uid://5ys3oet7rb14")
class_name Entity extends CharacterBody3D

signal component_added(node: Component)
signal component_deleted(node: Component)
signal component_renamed(node: Component)

@onready var synchronizer: MultiplayerSynchronizer = $MultiplayerSynchronizer
@onready var collider: CollisionShape3D = $CollisionShape3D
@onready var model: Model = $Model
@onready var agent: NavigationAgent3D = $NavigationAgent3D

var components: Dictionary[String, Component] = {}

func _on_component_renamed() -> void:
	for key in components.keys():
		var value: Component = components[key]
		if value.name == key:
			continue
		components.erase(key)
		components.set(value.name, value)
		component_renamed.emit(value)
		return
	push_warning("_on_component_renamed called but could not located renamed component.")

func _add_component(node: Component) -> void:
	node.renamed.connect(_on_component_renamed)
	components.set(node.name, node)
	component_added.emit(node)

func _del_component(node: Component) -> void:
	node.renamed.disconnect(_on_component_renamed)
	components.erase(node.name)
	component_deleted.emit(node)

func _find_components() -> void:
	for child in get_children():
		if not child is Component:
			continue
		if components.has(child.name):
			continue
		_add_component(child)

func _ready() -> void:
	_find_components()

func _process(delta: float) -> void:
	for component in components.values():
		component._process_update(delta)
		if is_multiplayer_authority():
			component._process_update_authority(delta)

func _physics_process(delta: float) -> void:
	for component in components.values():
		component._physics_update(delta)
		if is_multiplayer_authority():
			component._physics_update_authority(delta)
	move_and_slide()

func _on_child_entered_tree(child: Node) -> void:
	if child is Component:
		_add_component(child)

func _on_child_exiting_tree(child: Node) -> void:
	if child is Component:
		_del_component(child)
