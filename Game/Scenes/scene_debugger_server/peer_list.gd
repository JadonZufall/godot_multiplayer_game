extends VBoxContainer


var peers: Dictionary[int, Label] = {}

func _ready() -> void:
	Network.sv_peer_connected.connect(_on_peer_connected)
	Network.sv_peer_disconnected.connect(_on_peer_disconnected)
	Network.sv_peer_set_username.connect(_on_peer_set_username)

func _on_peer_connected(pid: int) -> void:
	var label: Label = Label.new()
	add_child(label)
	label.text = "[%d] %s" % [pid, "<null>"]
	label.name = str(pid)
	peers.set(pid, label)

func _on_peer_disconnected(pid: int) -> void:
	var label: Label = peers.get(pid)
	if not label:
		push_error("Unable to locate label for [%d] %s" % [pid, "<null>"])
		return
	label.queue_free()

func _on_peer_set_username(pid: int, username: String) -> void:
	var label: Label = peers.get(pid)
	if not label:
		push_error("Unable to locate label for [%d] %s" % [pid, username])
		return
	label.text = "[%d] %s" % [pid, username]
