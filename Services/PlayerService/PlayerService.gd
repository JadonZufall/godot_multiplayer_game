extends Service

signal player_join(data: PlayerData)
signal player_left(data: PlayerData)


func _ready() -> void:
	Network.sv_peer_connected.connect(_on_player_join)
	Network.sv_peer_disconnected.connect(_on_player_left)

func _on_player_join(pid: int) -> void:
	var player_data: PlayerData = PlayerData.new()
	player_data.pid = pid
	add_child(player_data)
	player_join.emit(player_data)

func _on_player_left() -> void:
	
	player_left.emit()
