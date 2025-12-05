extends HBoxContainer

@onready var username_input: LineEdit = $username_input
@onready var username_submit: Button = $username_submit

func _assign_username() -> void:
	Network.network_set_username(username_input.text)
	username_input.editable = false
	username_submit.disabled = true

func _on_username_input_text_submitted(new_text: String) -> void:
	_assign_username()

func _on_username_submit_pressed() -> void:
	_assign_username()
