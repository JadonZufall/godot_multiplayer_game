extends Component

@export var is_enabled: bool = true

func _process_update_authority(delta: float) -> void:
	if not is_enabled:
		return
	if not entity.is_on_floor():
		entity.velocity += entity.get_gravity() * delta
