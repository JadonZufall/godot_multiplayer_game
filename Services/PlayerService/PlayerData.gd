class_name PlayerData extends Node

signal player_join(player_data: PlayerData)
signal player_quit(player_data: PlayerData)

var _pid: int = -1
var _uuid: String
var _username: String
var _session: Dictionary = {}
var _player: Entity = null


var pid: int :
	set(new):
		_pid = new
	get:
		return _pid

var uuid: String :
	set(new): 
		_uuid = new
	get: 
		return _uuid

var username: String :
	set(new):
		_username = new
	get:
		return _username

var is_online: bool:
	set(new):
		if new: return
		pid = -1
	get: 
		return pid != -1

func _serialize() -> void:
	if not multiplayer.is_server(): return PlayerService._error_log("PlayerData._serialize() failed, cannot be performed on client.")
	# TODO


signal listen_save(error_code: Network.ErrorCode)
@rpc("any_peer", "call_remote", "reliable")
func receive_save(sender_id: int, error_code: Network.ErrorCode) -> void:
	listen_save.emit(error_code)
	for listener in listen_save.get_connections():
		listen_save.disconnect(listener)
	if error_code != Network.ErrorCode.OKAY:
		return PlayerService._error_log("PlayerData.receive_save() error_code=%d" % error_code)

func request_save(_listener: Callable=Network.NO_LISTENER) -> void:
	if _listener != Network.NO_LISTENER:
		listen_save.connect(_listener)
	_request_save.rpc_id(1, Network.local_pid)

@rpc("authority", "call_remote", "reliable")
func _request_save(sender_id: int) -> void:
	# Only the server should be executing this function.
	if not multiplayer.is_server(): 
		PlayerService._error_log("PlayerData.request_save() failed, cannot be performed on client.")
		receive_save.rpc_id(sender_id, Network.local_pid, Network.ErrorCode.INVALID_DESTINATION)
		return
	
	# Only the player that is represented by this data has permission to make this call.
	if sender_id != pid:
		PlayerService._error_log("PlayerData.request_save() failed, pid mismatch %d (requester) != %d (player)" % [sender_id, pid])
		receive_save.rpc_id(sender_id, Network.local_pid, Network.ErrorCode.NO_PERMISSION)
		return

signal listen_load(error_code: Network.ErrorCode)
@rpc("any_peer", "call_remote", "reliable")
func receive_load(sender_id: int, error_code: Network.ErrorCode) -> void:
	pass

func request_load(player_id: String, _listener: Callable=Network.NO_LISTENER) -> void:
	if _listener != Network.NO_LISTENER:
		listen_load.connect(_listener)
	_request_load.rpc_id(1, Network.local_pid, player_id)

@rpc("authority", "call_remote", "reliable")
func _request_load(sender_id: int, player_id: String) -> void:
	if not multiplayer.is_server(): return PlayerService._error_log("PlayerData.request_load() failed, cannot be performed on client.")
	# TODO

@rpc("authority", "call_remote", "reliable")
func request_set_username(value: String) -> void:
	if not multiplayer.is_server(): return PlayerService._error_log("PlayerData.request_set_username() failed, cannot be performed on client.")
	# TODO

@rpc("authority", "call_remote", "reliable")
func request_spawn_player() -> void:
	if not multiplayer.is_server(): return PlayerService._error_log("PlayerData.request_spawn_player() failed, cannot be performed on client.")
	# TODO
