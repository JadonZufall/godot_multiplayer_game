extends Component

@export var is_enabled: bool = false


func _ready() -> void:
	super._ready()
	_connect.call_deferred()

func _connect() -> void:
	entity.agent.target_reached.connect(_on_target_reached)

func _on_target_reached() -> void:
	if not is_enabled:
		return


func _process_update_authority(_delta: float) -> void:
	if not is_enabled:
		return
	
