class_name StateMachine extends Node

@export var initial_state: State

var states: Dictionary = {}
var current_state: State

func _ready() -> void:
	for child in self.get_children():
		if child is not State:
			push_warning("Child of StateMachine is not a State: %s" % child.name)
			continue
		self.states[child.name] = child
		child.transitioned.connect(_on_transition)
	
	if initial_state:
		self.current_state = self.initial_state
		self.current_state._enter()

func _on_transition(state_name: StringName) -> void:
	if not self.states.has(state_name):
		push_error("Unfamiliar state: %s" % state_name)
		return
	
	if self.states[state_name] == self.current_state:
		return
	
	if self.current_state:
		self.current_state._exit()
	
	self.current_state = states[state_name]
	self.current_state._enter()

func _input(event: InputEvent) -> void:
	if not self.current_state:
		return
	self.current_state._update_input(event)

func _physics_process(delta: float) -> void:
	if not self.current_state:
		return
	self.current_state._update_physics(delta)
