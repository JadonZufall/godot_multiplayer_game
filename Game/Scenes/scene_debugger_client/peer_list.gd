extends VBoxContainer

var _peers: Dictionary[int, Label] = {}


func _ready() -> void:
	Network.cl_peer_connected.connect(_on_peer_connected)
	Network.cl_peer_disconnected.connect(_on_peer_disconnected)
	Network.cl_peer_set_username.connect(_on_peer_set_username)

func _on_peer_set_username(pid: int, username: String) -> void:
	if not _peers.has(pid):
		# Not error will also trigger for self
		return
	var label: Label = _peers[pid]
	label.text = "[%d] %s" % [pid, username]

func _on_peer_connected(pid: int) -> void:
	var label: Label = Label.new()
	add_child(label)
	label.text = "[%d] %s" % [pid, "<null>"]
	label.name = str(pid)
	_peers.set(pid, label)

func _on_peer_disconnected(pid: int) -> void:
	if not _peers.has(pid):
		Network.cout("No peer found [%d] %s" % [pid, "<null>"])
		push_error("No peer found [%d] %s" % [pid, "<null>"])
		return
	var label: Label = _peers[pid]
	label.queue_free()
