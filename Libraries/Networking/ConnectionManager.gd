extends Node

const PORT: int = 25565                                                                             # Any number 0 - 65535 (Ports < 1024 are priviledged and require elevated permissions)
const MAX_CLIENTS: int = 32                                                                         # Any number up to 4095 may be used

func host_server() -> void:
	# Being hosting as the server.
	var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	var result: Error = peer.create_server(PORT, MAX_CLIENTS)
	if result == OK:
		multiplayer.multiplayer_peer = peer
		ServerManager.on_server_host()
		print("Server created.")
	else:
		print("Failed to create server")

func join_sever(ip_address: String) -> void:
	# Join an exsisting server as the client.
	var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	var result: Error = peer.create_client(ip_address, PORT)
	if result == OK:
		multiplayer.multiplayer_peer = peer
		ClientManager.on_server_join()
		print("Connected to server.")
	else:
		print("Failed to connect to server.")
