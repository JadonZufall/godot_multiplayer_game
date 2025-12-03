extends Component

@export var is_enabled: bool = false


func _ready() -> void:
	super._ready()
	call_deferred("entity.agent.target_reached.connect", _on_target_reached)


func _on_target_reached() -> void:
	if not is_enabled:
		return


func _process_update_authority(delta: float) -> void:
	if not is_enabled:
		return
	
