@icon("res://Editor/Icons/PackedScene.svg")
extends Node
@onready var ui_loader: SceneTreeUI = $"UI Loader"
@onready var world_2d: SceneTree2D = $"2D World"
@onready var world_3d: SceneTree3D = $"3D World"


@export var server_debugger: PackedScene
@export var autoload_ui: Array[PackedScene] = []
@export var autoload_2d: Array[PackedScene] = []
@export var autoload_3d: Array[PackedScene] = []


func _ready() -> void:
	var args = Array(OS.get_cmdline_args())
	
	# If the flags contain -s run as server
	if args.has("-s"):
		ui_loader.add_child(server_debugger.instantiate())
		Network.sv_open()
	
	
	for scene in autoload_ui:
		ui_loader.add_child(scene.instantiate())
	
	for scene in autoload_2d:
		world_2d.add_child(scene.instantiate())
	
	for scene in autoload_3d:
		world_3d.add_child(scene.instantiate())
