extends MultiplayerSpawner

@export var player_information_scene: PackedScene


func _ready() -> void:
	multiplayer.peer_connected.connect(on_connect)
	multiplayer.peer_disconnected.connect(on_disconnect)

func on_connect(id: int) -> void:
	if not multiplayer.is_server(): return
	var player_info: PlayerInfo = player_information_scene.instantiate()
	player_info.id = id
	player_info.name = str(id)
	get_node(spawn_path).call_deferred("add_child", player_info)
	player_info.set_multiplayer_authority(id)

func on_disconnect(id: int) -> void:
	if not multiplayer.is_server(): return
	
