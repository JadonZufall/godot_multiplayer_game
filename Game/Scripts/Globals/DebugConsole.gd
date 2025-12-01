extends Node


var environment: Dictionary[String, Dictionary] = {}
enum ENV_PROPS { NAME, TYPE, CALL, PROPERTIES, PROTECTED }
enum ENV_TYPE { BUILT_IN, FUNCTION, VALUE }
enum EXEC_ERROR { NONE, UNKNOWN_COMMAND }

func exec(input: String) -> Dictionary:
	var tokens: Array[String] = input.split(" ")
	if tokens.size() == 0:
		return {"error": EXEC_ERROR.NONE, "output": ""}
	
	var key: String = tokens[0]
	if not environment.has(key.to_lower()):
		return {"error": EXEC_ERROR.UNKNOWN_COMMAND, "output": ""}
	
	var value: Dictionary = environment.get(key, null)
	if value[ENV_PROPS.TYPE] == ENV_TYPE.FUNCTION:
		var result: Dictionary = value[ENV_PROPS.CALL].call(tokens.slice(1))
		return result
	# TODO: Print value if just one variable
	# TODO: Error in confusion otherwise
	return {"error": EXEC_ERROR.NONE, "output": ""}

func cmd_none(args: Array) -> void:
	pass

func cmd_alias(args: Array) -> void:
	pass

func cmd_clear(args: Array) -> void:
	pass

func cmd_print(args: Array) -> void:
	pass

func cmd_disconnect(args: Array) -> void:
	pass

func cmd_quit(args: Array) -> void:
	pass

func del_environment_variable(key: String) -> bool:
	if not environment.has(key) or environment[key][ENV_PROPS.PROTECTED]:
		return false
	environment.erase(key)
	return true

func set_environment_variable(key: String, type: ENV_TYPE, args: Dictionary={}, call: Callable=cmd_none, protected: bool=false) -> bool:
	if environment.has(key) and environment[key].get(ENV_PROPS.PROTECTED, false):
		return false
	
	var value: Dictionary = {}
	value[ENV_PROPS.NAME] = key
	value[ENV_PROPS.TYPE] = type
	if value[ENV_PROPS.TYPE] == ENV_TYPE.FUNCTION:
		value[ENV_PROPS.CALL] = call
	value[ENV_PROPS.PROTECTED] = protected
	value[ENV_PROPS.PROPERTIES] = args.duplicate(false)
	return true

func _ready() -> void:
	set_environment_variable("alias", ENV_TYPE.BUILT_IN, {
		"description": "Assign an alias to an exsisting command.",
	}, cmd_alias, true)
	set_environment_variable("clear", ENV_TYPE.BUILT_IN, {
		"description": "Clear the console output.",
	}, cmd_alias, true)
	set_environment_variable("print", ENV_TYPE.BUILT_IN, {
		"description": "Print the standard output.",
	}, cmd_print, true)
	set_environment_variable("disconnect", ENV_TYPE.BUILT_IN, {
		"description": "",
	}, cmd_disconnect, true)
	set_environment_variable("quit", ENV_TYPE.BUILT_IN, {
		"description": "",
	}, cmd_quit, true)
