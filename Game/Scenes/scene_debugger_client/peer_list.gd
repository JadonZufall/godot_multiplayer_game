extends VBoxContainer


func _ready() -> void:
	Network.cl_peer_connected.connect(_on_peer_connected)
	Network.cl_peer_disconnected.connect(_on_peer_disconnected)

func _on_peer_connected(pid: int) -> void:
	pass

func _on_peer_disconnected(pid: int) -> void:
	pass
