class_name Console extends Window

@onready var stream_out: ConsoleStreamOut = $vbox/stream_out
@onready var stream_in: LineEdit = $vbox/hbox/stream_in
@onready var btn_submit: Button = $vbox/hbox/btn_submit


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func parse(command: String) -> void:
	stream_out.write_line(command)
	stream_out.write_line(stream_out.format_error("SyntaxError", "Did not reconize command %s" % command))
	stream_in.call_deferred("set_editable", true)
	stream_in.call_deferred("edit")

func _on_btn_submit_pressed() -> void:
	stream_in.text_submitted.emit(stream_in.text)

func _on_stream_in_text_submitted(new_text: String) -> void:
	stream_in.editable = false
	stream_in.clear()
	parse(new_text)

func _on_close_requested() -> void:
	visible = false
