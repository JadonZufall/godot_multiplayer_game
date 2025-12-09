class_name PlayerData extends Node

const TOKEN_LEN: int = 64
const TOKEN_UNIX_PADDING: int = 12
const TOKEN_UNIX_DATE_FORMAT: String = "%012.0f"
const TOKEN_DELIMITER: String = "|"
const TOKEN_EXPIRE_SECONDS: int = 0
const TOKEN_EXPIRE_MINUTES: int = 0
const TOKEN_EXPIRE_HOURS: int = 0
const TOKEN_EXPIRE_DAYS: int = 1

signal player_join
signal player_quit

var pid: int = -1
var uuid: String
var username: String
var token: String
var is_connected: bool:
	get: return pid != -1

static func unix_delta_time(days: int, hours: int, minutes: int, seconds: int) -> int:
	var result: int = days
	result *= 24  # 24 hours in a day
	result += hours
	result *= 60  # 60 minutes in an hour
	result += minutes
	result *= 60  # 60 seconds in a minute
	result += seconds
	return result

static func validate_token(token: String) -> Dictionary:
	var data: Array[String] = token.split(TOKEN_DELIMITER)
	return {}

static func generate_token(username: String) -> String:
	var result: String = ""
	
	var issue_date: float = Time.get_unix_time_from_system()
	var expire_date: float = issue_date + unix_delta_time(TOKEN_EXPIRE_DAYS, TOKEN_EXPIRE_HOURS, TOKEN_EXPIRE_MINUTES, TOKEN_EXPIRE_SECONDS)
	
	result += TOKEN_UNIX_DATE_FORMAT % issue_date
	result += TOKEN_DELIMITER
	result += TOKEN_UNIX_DATE_FORMAT % expire_date
	result += TOKEN_DELIMITER
	result += username
	result += TOKEN_DELIMITER
	
	var rand: String = ""
	for i in range(TOKEN_LEN):
		pass
	
	return result
