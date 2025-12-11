extends Service

signal player_join(data: PlayerData)
signal player_left(data: PlayerData)

var _pdata: Dictionary[int, PlayerData] = {}
static var _Random: RandomNumberGenerator = RandomNumberGenerator.new()

static func generate_hex(len: int) -> String:
	var result: String = ""
	for i in range(len):
		if _Random.randf() < 0.5:
			result += char(_Random.randi_range(48, 57))
		else:
			result += char(_Random.randi_range(97, 102))
	return result

static func generate_uuid_v4() -> String:
	# 8-4-4-4-12
	return "%s-%s-%s-%s-%s" % [generate_hex(8), generate_hex(4), generate_hex(4), generate_hex(4), generate_hex(12)]

func _pdata_clear() -> void:
	_pdata.clear()

func _ready() -> void:
	Network.sv_host.connect(_on_server_host)
	Network.sv_exit.connect(_on_server_exit)
	Network.cl_join.connect(_on_client_join)
	Network.cl_exit.connect(_on_client_exit)

func _error_log(message: String) -> void: 
	Network.cout("[ERROR] (PlayerService) %s" % message)
	push_error("[ERROR] (PlayerService) %s" % message)
func _error_listeners_already_connected() -> void: return _error_log("Unabled to bind listeners for, listeners already connected.")
func _error_no_player_data(pid: int=-1) -> void: return _error_log("No player_data for %d" % pid)
func _error_duplicate_player_data(pid: int=-1) -> void: return _error_log("Duplicate player_data for %d" % pid)
func _error_already_disconnected(pid: int=-1) -> void: return _error_log("Failed to disconnect player_data for %d, player was already disconnected." % pid)

func _is_network_listeners_connected() -> bool:
	var result: bool = false
	result = result or Network.sv_peer_connected.is_connected(_on_player_join)
	result = result or Network.sv_peer_disconnected.is_connected(_on_player_left)
	result = result or Network.cl_peer_connected.is_connected(_on_player_join)
	result = result or Network.cl_peer_disconnected.is_connected(_on_player_left)
	return result

func _on_server_host() -> void:
	if _is_network_listeners_connected():
		return _error_listeners_already_connected()
	_pdata_clear()
	Network.sv_peer_connected.connect(_on_player_join)
	Network.sv_peer_disconnected.connect(_on_player_left)

func _on_server_exit() -> void:
	if _is_network_listeners_connected():
		return _error_listeners_already_connected()
	_pdata_clear()
	Network.sv_peer_connected.disconnect(_on_player_join)
	Network.sv_peer_disconnected.disconnect(_on_player_left)

func _on_client_join() -> void:
	if _is_network_listeners_connected():
		return _error_listeners_already_connected()
	_pdata_clear()
	Network.cl_peer_connected.connect(_on_player_join)
	Network.cl_peer_disconnected.connect(_on_player_left)

func _on_client_exit() -> void:
	if _is_network_listeners_connected():
		return _error_listeners_already_connected()
	_pdata_clear()
	Network.cl_peer_connected.disconnect(_on_player_join)
	Network.cl_peer_disconnected.connect(_on_player_left)

func _on_player_join(pid: int) -> void:
	var player_data: PlayerData = PlayerData.new()
	player_data.uuid = generate_uuid_v4()
	player_data.pid = pid
	
	_pdata[pid] = player_data
	add_child(player_data)
	
	player_join.emit(player_data)
	player_data.player_join.emit(player_data)

func _on_player_left(pid: int) -> void:
	if not _pdata.has(pid): return _error_no_player_data(pid)
	var player_data: PlayerData = _pdata[pid]
	player_data.player_quit.emit(player_data)
	player_data.queue_free()
	_pdata.erase(pid)
