extends Node
@onready var world_ui: Control = $UI
@onready var world_2d: Node2D = $"2D World"
@onready var world_3d: Node3D = $"3D World"

@export var autoload_ui: Array[PackedScene] = []
@export var autoload_2d: Array[PackedScene] = []
@export var autoload_3d: Array[PackedScene] = []


func _ready() -> void:
	for scene in autoload_ui:
		world_ui.add_child(scene.instantiate())
