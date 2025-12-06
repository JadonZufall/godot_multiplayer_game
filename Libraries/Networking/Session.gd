extends Node


const SESSION_TYPE_NONE: String = "NO"
const SESSION_TYPE_SERVER: String = "SV"
const SESSION_TYPE_CLIENT: String = "CL"

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
