@tool
extends Node3D

@export_range(0.0, 1.0, 0.01) var interpolation: float = 0.5

@onready var hip: Marker3D = $hip
@onready var knee: Marker3D = $hip/knee
@onready var foot: Marker3D = $hip/knee/foot

@onready var ik_destination: Marker3D = $"../ik_destination"
@onready var ik_intermediary: Marker3D = $"../ik_intermediary"


@export_tool_button("apply_ik")
var action_apply_ik: Callable = apply_ik
func apply_ik() -> void:
	pass
