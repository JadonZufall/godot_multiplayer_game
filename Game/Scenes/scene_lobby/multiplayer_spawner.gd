extends MultiplayerSpawner

@export var network_player: PackedScene
@export var spawn_pos: Vector3 = Vector3.ONE

func _ready() -> void:
	multiplayer.peer_connected.connect(spawn_player)
	for id in multiplayer.get_peers():
		spawn_player(id)

func spawn_player(id: int) -> void:
	if not multiplayer.is_server(): return
	print("Spawning Network Player %d" % id)
	var player: Node3D = network_player.instantiate()
	player.name = str(id)
	player.position = spawn_pos
	get_node(spawn_path).call_deferred("add_child", player)
