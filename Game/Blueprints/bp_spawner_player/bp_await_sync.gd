extends Node

var _pid: int
var _player: Entity

func _on_sync() -> void:
	_player._cl_auth_ready.rpc_id(_pid)
	queue_free()

func sync_ready(pid: int, player: Entity) -> void:
	_pid = pid
	_player = player
	_player.synchronizer.synchronized.connect(_on_sync)
