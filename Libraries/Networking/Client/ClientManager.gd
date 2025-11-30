extends Node


var _connected: Array[int] = []
var _usernames: Dictionary[int, String] = {}


func on_server_join() -> void:
	# When the client connects to the server connect all these listeners.
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.connected_to_server.connect(_on_server_connected)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func on_server_leave() -> void:
	# Disconnect / clean up various listeners
	multiplayer.connection_failed.disconnect(_on_connection_failed)
	multiplayer.connected_to_server.disconnect(_on_server_connected)
	multiplayer.server_disconnected.disconnect(_on_server_disconnected)
	multiplayer.peer_connected.disconnect(_on_peer_connected)
	multiplayer.peer_disconnected.disconnect(_on_peer_disconnected)

func _on_server_connected() -> void:
	print("[CLIENT] Server connected")

func _on_server_disconnected() -> void:
	print("[CLIENT] Server disconnected")
	on_server_leave()

func _on_connection_failed() -> void:
	on_server_leave()
	push_error("[CLIENT] Failed to connect to server.")

func _on_peer_connected(peer_id: int) -> void:
	print("[CLIENT] Peer (%d) connected to server." % peer_id)
	_connected.append(peer_id)

func _on_peer_disconnected(peer_id: int) -> void:
	print("[CLIENT] Peer (%d) disconnected from server." % peer_id)
	_connected.erase(peer_id)

@rpc
func sync_connected_peers(peer_ids: Array[int]) -> void:
	for id in peer_ids:
		if _connected.count(peer_ids) == 0:
			_connected.append(id)

@rpc
func send_kick_message(message: String) -> void:
	print(message)
