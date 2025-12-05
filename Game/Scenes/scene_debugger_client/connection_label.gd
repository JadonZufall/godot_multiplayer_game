extends Label


func _ready() -> void:
	Network.cl_join.connect(_on_join)
	Network.cl_exit.connect(_on_exit)

func _on_join() -> void:
	text = "Connected"

func _on_exit() -> void:
	text = "Disconnected"
