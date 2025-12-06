extends Node


const SESSION_TYPE_NONE: String = "NO"
const SESSION_TYPE_SERVER: String = "SV"
const SESSION_TYPE_CLIENT: String = "CL"

signal pdata_modified(pid: int, player_data: Dictionary[int, Dictionary])
signal pdata_removed(pid: int)

var _type: String = SESSION_TYPE_NONE
var type: String : get = _get_session_type
func _get_session_type() -> String: return _type

var _data: Dictionary[int, Dictionary] = {}

func _ready() -> void:
	Network.sv_host.connect(_sv_session_host)
	Network.sv_exit.connect(_sv_session_exit)
	Network.cl_join.connect(_cl_session_join)
	Network.cl_exit.connect(_cl_session_exit)

func _sv_session_host() -> void: _type = SESSION_TYPE_SERVER
func _sv_session_exit() -> void: _type = SESSION_TYPE_NONE
func _cl_session_join() -> void: _type = SESSION_TYPE_CLIENT
func _cl_session_exit() -> void: _type = SESSION_TYPE_NONE

func pdata_get(pid: int, default=null) -> Dictionary:
	return _data.get(pid, default)

func pdata_erase(pid: int) -> void:
	_data.erase(pid)
	pdata_removed.emit(pid)

func pdata_has(pid: int) -> bool:
	return _data.has(pid)

func pdata_set(pid: int, data: Dictionary) -> void:
	_data.set(pid, data)
	pdata_modified.emit(pid, _data[pid])

func pdata_update(pid: int, data: Dictionary) -> void:
	if not _data.has(pid):
		Network.cout("No pdata for %d" % pid)
		push_error("No player data for %d" % pid)
		return
	_data[pid].assign(data)
	pdata_modified.emit(pid, _data[pid])
