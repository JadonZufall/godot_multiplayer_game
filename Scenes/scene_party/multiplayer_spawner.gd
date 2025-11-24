extends MultiplayerSpawner

@export var player_label: PackedScene
var player_labels: Dictionary[int, Node] = {}


func _ready() -> void:
	multiplayer.peer_connected.connect(on_connect)
	multiplayer.peer_disconnected.connect(on_disconnect)
	
	if not multiplayer.is_server(): return
	var label: Control = player_label.instantiate()
	label.name = "Host"

	get_node(spawn_path).call_deferred("add_child", label)
	

func on_connect(id: int) -> void:
	if not multiplayer.is_server(): return
	print("Server: Player Connected")
	var label: Control = player_label.instantiate()
	label.name = str(id)

	get_node(spawn_path).call_deferred("add_child", label)
	player_labels.set(id, label)
	

func on_disconnect(id: int) -> void:
	if not multiplayer.is_server(): return
	print("Client: Player Disconnected")
	var label: Node = player_labels.get(id)
	if label is Node:
		label.queue_free()
	
	
	
