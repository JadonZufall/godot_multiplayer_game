@tool
extends PanelContainer

# Shared
@export var default_value: int = 10

signal value_modified(value: Vector2)
var _value: Vector2 = Vector2.ZERO
func get_value() -> Vector2:
	return Vector2(input_mesh_size_x.text.to_int(), input_mesh_size_y.to_int())

func _ready() -> void:
	_value = get_value()
	_update_reset_button_x()
	_update_reset_button_y()

func _on_value_modified(value: Vector2) -> void:
	_value = value

# Size X Functions
@export var input_mesh_size_x: LineEdit
@export var button_reset_mesh_size_x: Button
func _update_reset_button_x() -> void:
	var value: int = input_mesh_size_x.text.to_int()
	if value == default_value:
		button_reset_mesh_size_x.disabled = true
	else:
		button_reset_mesh_size_x.disabled = false

func _on_button_reset_mesh_size_x_pressed() -> void:
	input_mesh_size_x.text = "%d" % default_value
	button_reset_mesh_size_x.disabled = true

func _on_input_mesh_size_x_editing_toggled(toggled_on: bool) -> void:
	_update_reset_button_x()
	if not toggled_on and get_value() != _value:
		value_modified.emit(get_value())
	

# Size Y Functions
@export var input_mesh_size_y: LineEdit
@export var button_reset_mesh_size_y: Button
func _update_reset_button_y() -> void:
	var value: int = input_mesh_size_y.text.to_int()
	if value == default_value:
		button_reset_mesh_size_y.disabled = true
	else:
		button_reset_mesh_size_y.disabled = false

func _on_button_reset_mesh_size_y_pressed() -> void:
	input_mesh_size_y.text = "%d" % default_value
	button_reset_mesh_size_y.disabled = true

func _on_input_mesh_size_y_editing_toggled(toggled_on: bool) -> void:
	_update_reset_button_y()
	if not toggled_on and get_value() != _value:
		value_modified.emit(get_value())
