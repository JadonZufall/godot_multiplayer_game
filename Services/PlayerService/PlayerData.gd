class_name PlayerData extends Node

signal player_join
signal player_quit

var _pid: int = -1
var _uuid: String
var _username: String
var _session: Dictionary


var pid: int :
	set(new):
		_pid = new
	get:
		return _pid

var uuid: String :
	set(new): 
		_uuid = new
	get: 
		return _uuid

var username: String :
	set(new):
		_username = new
	get:
		return _username

var is_connected: bool:
	set(new):
		if new: return
		pid = -1
	get: 
		return pid != -1
