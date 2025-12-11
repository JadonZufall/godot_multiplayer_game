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

var is_connected: bool:
	set(new):
		if new: return
		pid = -1
	get: 
		return pid != -1

func _serialize() -> void:
	if not multiplayer.is_server(): return PlayerService._error_log("PlayerData._serialize() failed, cannot be performed on client.")
	# TODO


signal listen_save(error_code: int)
@rpc("any_peer", "call_remote", "reliable")
func receive_save(sender_id: int, error_code: int) -> void:
	listen_save.emit(error_code)
	if error_code != Network.ErrorCode.OKAY:
		return PlayerService._error_log("PlayerData.receive_save() error_code=%d" % error_code)

func request_save(receive: Callable? = null) -> void:
	listen_save.connect(receive)
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
	
	
	
@rpc("authority", "call_remote", "reliable")
func request_load(uuid: String) -> void:
	if not multiplayer.is_server(): return PlayerService._error_log("PlayerData.request_load() failed, cannot be performed on client.")
	# TODO

@rpc("authority", "call_remote", "reliable")
func request_set_username(username: String) -> void:
	if not multiplayer.is_server(): return PlayerService._error_log("PlayerData.request_set_username() failed, cannot be performed on client.")
	# TODO

@rpc("authority", "call_remote", "reliable")
func request_spawn_player() -> void:
	if not multiplayer.is_server(): return PlayerService._error_log("PlayerData.request_spawn_player() failed, cannot be performed on client.")
	# TODO
