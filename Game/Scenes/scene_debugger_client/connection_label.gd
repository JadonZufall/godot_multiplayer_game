extends Label


func _ready() -> void:
	Network.cl_join.connect(_on_join)
	Network.cl_exit.connect(_on_exit)
	Network.cl_peer_set_username.connect(_on_peer_set_username)

func _on_peer_set_username(pid: int, username: String) -> void:
	if Network.local_pid != pid:
		return
	text = "Connected as [%d] %s" % [Network.local_pid, username]

func _on_join() -> void:
	text = "Connected as [%d] %s" % [Network.local_pid, "<null>"]

func _on_exit() -> void:
	text = "Disconnected"
