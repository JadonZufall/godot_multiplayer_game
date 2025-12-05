extends Node

signal sv_host()
signal sv_exit()
signal sv_peer_connected(pid: int)
signal sv_peer_disconnected(pid: int)
signal sv_peer_set_username(pid: int, username: String)

signal cl_join()
signal cl_exit()
signal cl_peer_set_username(pid: int, username: String)

signal user_connected(pid: int)
signal user_disconnected(pid: int)

const PORT: int = 25565                                                                             # Any number 0 - 65535 (Ports < 1024 are priviledged and require elevated permissions)
const ADDR: String = "localhost"
const MAX_CLIENTS: int = 32                                                                         # Any number up to 4095 may be used

const MIN_USERNAME_LENGTH: int = 3
const MAX_USERNAME_LENGTH: int = 20


var _session_data: Dictionary[int, Dictionary] = {}

func sv_open() -> void:
	# Being hosting as the server.
	var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	var result: Error = peer.create_server(PORT, MAX_CLIENTS)
	if result != OK:
		if result == ERR_ALREADY_EXISTS:
			push_error("Failed to host server ERR_ALREADY_EXISTS")
		elif result == ERR_CANT_CREATE:
			push_error("Failed to host server ERR_CANT_CREATE")
		else:
			push_error("Failed to host server UNKNOWN")
		return
	
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_sv_on_peer_connected)
	multiplayer.peer_disconnected.connect(_sv_on_peer_disconnected)
	print("[SV] Hosting to port %d." % PORT)
	sv_host.emit()

func sv_quit() -> void:
	if not multiplayer.is_server():
		push_error("No permission to call sv_quit from the client.")
		return
	multiplayer.multiplayer_peer.close.call_deferred()
	multiplayer.multiplayer_peer = null
	print("[SV] Closed.")
	sv_exit.emit()

func cl_open(ip_address: String) -> void:
	# Join an exsisting server as the client.
	var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	var result: Error = peer.create_client(ip_address, PORT)
	if result != OK:
		if result == ERR_ALREADY_IN_USE:
			push_error("Failed to join server ERR_ALREADY_IN_USE")
		elif result == ERR_CANT_CREATE:
			push_error("Failed to join server ERR_CANT_CREATE")
		else:
			push_error("Failed to join server UNKNOWN")
	
	multiplayer.multiplayer_peer = peer
	print("[CL] Connected to server.")
	cl_join.emit()

func cl_quit() -> void:
	if multiplayer.is_server():
		push_error("No permission to call cl_quit from the server.")
		return
	multiplayer.multiplayer_peer.close.call_deferred()
	multiplayer.multiplayer_peer = null
	print("[CL] Closed.")
	cl_exit.emit()

# EVENT LISTENERS
func _sv_on_peer_connected(pid: int) -> void:
	if not multiplayer.is_server():
		push_error("No permission to call _sv_on_peer_connected from the client.")
		return
	sv_new_player_data(pid)
	sv_peer_connected.emit(pid)

func _cl_on_peer_connected(pid: int) -> void:
	if multiplayer.is_server():
		push_error("No permission to call _cl_on_peer_connected from the server.")
		return

func _sv_on_peer_disconnected(pid: int) -> void:
	if not multiplayer.is_server():
		push_error("No permission to call _sv_on_peer_disconnected from the client.")
		return
	sv_del_player_data(pid)
	sv_peer_disconnected.emit(pid)

func _cl_on_peer_disconnected(pid: int) -> void:
	if multiplayer.is_server():
		if multiplayer.is_server():
			push_error("No permission to call _cl_on_peer_disconnected from the server.")
			return

# REMOTE PROCEDURE CALL
@rpc("any_peer", "call_remote", "reliable", 0)
func network_free_player_data(pid: int) -> void:
	# Clear the player data.
	_session_data.erase(pid)

@rpc("any_peer", "call_remote", "reliable", 0)
func network_assign_player_data(pid: int, data: Dictionary) -> void:
	# Override exsisting player data.
	_session_data[pid] = data

@rpc("any_peer", "call_remote", "reliable", 0)
func network_update_player_data(pid: int, data: Dictionary) -> void:
	# Only update included values.
	_session_data[pid].assign(data)

func sv_new_player_data(pid: int) -> void:
	if not multiplayer.is_server():
		push_error("No permission to call sv_new_player_data from the client.")
		return
	if _session_data.has(pid):
		push_error("new_player_data(pid=%d) duplicate playerIDs" % [pid])
		return
	_session_data.set(pid, { 
		"pid": pid,
		"ip": -1,
		"username": "",
	})

func sv_del_player_data(pid: int) -> void:
	if not multiplayer.is_server():
		push_error("No permission to call sv_del_player_data from the client.")
		return
	_session_data.erase(pid)

func sv_get_player_data(pid: int) -> Dictionary:
	if not multiplayer.is_server():
		push_error("No permission to call sv_get_player_data from the client.")
		return {}
	if not _session_data.has(pid):
		sv_new_player_data(pid)
	return _session_data[pid]

func network_set_username(username: String) -> void:
	sv_set_username.rpc_id(1, username)

# Only the server can execute this remotely
@rpc("any_peer", "call_remote", "reliable", 0)
func sv_set_username(username: String) -> void:
	if not multiplayer.is_server():
		push_error("No permission to call sv_set_username from the client.")
		return
	var pid: int = multiplayer.get_remote_sender_id()
	
	# TODO: Validate username
	if username.length() < MIN_USERNAME_LENGTH or username.length() > MAX_USERNAME_LENGTH:
		pass
	
	# Update player data
	var player_data: Dictionary = _session_data[pid]
	player_data.set("username", username)
	
	# Call function on all peers
	network_relay_set_username.rpc(pid, username)
	sv_peer_set_username.emit(pid, username)

@rpc("any_peer", "call_remote", "reliable", 0)
func network_relay_set_username(pid: int, username: String) -> void:
	if not _session_data.has(pid):
		_session_data.set(pid, {})
	var player_data: Dictionary = _session_data[pid]
	player_data.set("username", username)
	cl_peer_set_username.emit(pid, username)
	
