extends MultiplayerSpawner

@export var bp_await_sync: PackedScene
@export var bp_entity_player: PackedScene

func _enter_tree() -> void:
	if not multiplayer.is_server():
		return
	Network.sv_peer_connected.connect(_on_peer_connected)

func _on_peer_connected(pid: int) -> void:
	var parent: Node = get_node(spawn_path)
	var player: Entity = bp_entity_player.instantiate()
	player.name = str(pid)
	player.pid = pid
	parent.add_child(player)
	Network.cout("Spawned player for %d" % pid)
	
	var sync: Node = bp_await_sync.instantiate()
	sync.call_deferred("sync_ready", pid, player)
	
