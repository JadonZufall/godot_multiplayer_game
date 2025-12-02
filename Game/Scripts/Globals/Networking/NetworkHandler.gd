extends Node

const IP_ADDRESS: String = "localhost"
const PORT: int = 25565

var peer: ENetMultiplayerPeer
var client_type: String = "None"

func _ready() -> void:
	multiplayer.peer_connected.connect(on_peer_connected)
	multiplayer.peer_disconnected.connect(on_peer_disconnected)

@rpc("any_peer")
func quit_all_clients() -> void:
	get_tree().quit()

func start_server() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	client_type = "Server"

func start_client() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS, PORT)
	multiplayer.multiplayer_peer = peer
	client_type = "Client"

func on_peer_connected(id: int) -> void:
	if multiplayer.is_server():
		return

func on_peer_disconnected(id: int) -> void:
	if not multiplayer.is_server():
		return
