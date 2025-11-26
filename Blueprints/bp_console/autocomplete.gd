extends PanelContainer

@export var stream_in: LineEdit
@export var suggestions: Array[Label] = []

func hide_suggestions() -> void:
	for item in suggestions:
		item.visible = false

func show_suggestions() -> void:
	for item in suggestions:
		item.visible = true

func clear_suggestions() -> void:
	for item in suggestions:
		item.text = ""

func load_suggestions() -> void:
	var text_input = stream_in.text.to_lower().strip_edges(true, true)
	

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_stream_in_text_changed(new_text: String) -> void:
	pass

func _on_toggled_off() -> void: hide_suggestions()

func _on_toggled_on() -> void: pass

func _on_stream_in_editing_toggled(toggled_on: bool) -> void:
	if toggled_on: _on_toggled_on()
	else: _on_toggled_off()

func _on_stream_in_text_submitted(new_text: String) -> void:
	pass
