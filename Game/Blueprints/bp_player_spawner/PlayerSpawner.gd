extends MultiplayerSpawner


func _ready() -> void:
	if not multiplayer.is_server():
		return
	Network.player_connected.connect(_on_network_player_connected)


# Function can be called by any peer and 
@rpc("any_peer", "call_local", "reliable", 0)
func network_request_spawn_player(pid: int, username: String) -> void:
	# Debug statement to ensure that only the server can execute this function.
	if not multiplayer.is_server():
		push_error("network_request_spawn_player, is only intended to be executed on the server.")
		return
	
	

func _on_network_player_connected(pid: int) -> void:
	pass

func _on_network_player_disconnected(pid: int) -> void:
	pass
