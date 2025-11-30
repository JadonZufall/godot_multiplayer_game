extends Node

var _connected: Array[int] = []
var _usernames: Dictionary[int, String] = {}

func on_server_host() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func _on_peer_connected(peer_id: int) -> void:
	ClientManager.sync_connected_peers.rpc(_connected)
	_connected.append(peer_id)

func _on_peer_disconnected(peer_id: int) -> void:
	_connected.erase(peer_id)

func kick(peer_id: int, message: String) -> void:
	# Disconnects a peer from the server.
	ClientManager.send_kick_message.rpc_id(peer_id, message)
	multiplayer.multiplayer_peer.disconnect_peer(peer_id, false)

func close_server() -> void:
	if not multiplayer.is_server():
		push_error("ERROR, unable to close the server.  !mutliplayer.is_server()")
		return
	for peer_id in multiplayer.get_peers():
		if peer_id != multiplayer.get_unique_id():
			pass
	multiplayer.multiplayer_peer.close()
	print("[SERVER] ServerManager.close_server(), server is now closed.")

@rpc
func set_username(peer_id: int, username: String) -> Error:
	_usernames[peer_id] = username
	return OK
