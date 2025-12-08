extends Service


func _ready() -> void:
	Network.sv_peer_connected.connect(_on_player_join)
	Network.sv_peer_disconnected.connect(_on_player_quit)

func _on_player_join() -> void:
	pass

func _on_player_quit() -> void:
	pass
