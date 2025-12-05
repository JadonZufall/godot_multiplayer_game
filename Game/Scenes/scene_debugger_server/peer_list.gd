extends VBoxContainer


var peers: Dictionary[int, Node] = {}

func _ready() -> void:
	Network.sv_peer_connected.connect(_on_peer_connected)
	Network.sv_peer_disconnected.connect(_on_peer_disconnected)

func _on_peer_connected(pid: int) -> void:
	var label: Label = Label.new()
	add_child(label)
	label.text = str(pid)
	label.name = str(pid)
	peers[pid] = label

func _on_peer_disconnected(pid: int) -> void:
	var target: Label = peers.get(pid)
	if target:
		target.queue_free()
