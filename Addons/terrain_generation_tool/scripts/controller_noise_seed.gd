@tool
extends PanelContainer

@export var spinbox: SpinBox
@export var reset_button: Button
@export var default_value: int = 0

signal value_modified(value: int)
var _value: int = 0

func _ready() -> void:
	_value = get_value()

func get_value() -> int: return int(spinbox.value)

func set_value(value: int) -> void:
	_value = value
	spinbox.set_value_no_signal(value)
	value_modified.emit(_value)

func _on_noise_seed_value_changed(value: float) -> void: set_value(value)
