class_name PlayerData extends Node

signal player_join
signal player_quit

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

@rpc("any_peer", "call_remote", "reliable")
func receive_save(sender_id: int, error_code: int) -> void:
	pass

@rpc("authority", "call_remote", "reliable")
func request_save(sender_id: int) -> void:
	if not multiplayer.is_server(): return PlayerService._error_log("PlayerData.request_save() failed, cannot be performed on client.")
	if sender_id != pid:
		PlayerService._error_log("PlayerData.request_save() failed, pid mismatch %d (requester) != %d (player)" % [sender_id, pid])
		receive_save.rpc_id(sender_id, Network.ErrorCode.NO_PERMISSION)

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
