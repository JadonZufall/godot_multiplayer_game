@tool
extends PanelContainer

signal value_modified(value: Vector3)

@export var root: Window
@export var spin_x: SpinBox
@export var spin_y: SpinBox
@export var spin_z: SpinBox
@export var reset_button: Button
@export var default_value: Vector3 = Vector3.ZERO
var _value: Vector3 = Vector3.ZERO

func set_value(value: Vector3) -> void:
	spin_x.set_value_no_signal(value.x)
	spin_y.set_value_no_signal(value.x)
	spin_z.set_value_no_signal(value.x)
	value_modified.emit(get_value())

func get_value() -> Vector3:
	return Vector3(spin_x.value, spin_y.value, spin_z.value)

func _ready() -> void:
	_value = get_value()
	value_modified.emit(_value)

func _on_value_modified(value: Vector3) -> void:
	if value != default_value:
		reset_button.set_deferred("disabled", false)
	else:
		reset_button.set_deferred("disabled", true)

func _on_button_reset_noise_offset_pressed() -> void:
	set_value(default_value)

func _on_input_noise_offset_x_value_changed(value: float) -> void:
	_value = get_value()
	value_modified.emit(get_value())

func _on_input_noise_offset_y_value_changed(value: float) -> void:
	_value = get_value()
	value_modified.emit(_value)

func _on_input_noise_offset_z_value_changed(value: float) -> void:
	_value = get_value()
	value_modified.emit(_value)
