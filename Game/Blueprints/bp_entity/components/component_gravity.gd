class_name ComponentGravity extends Component

@export var is_enabled: bool = true
@export var gravity_scale: float = 1.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _update(delta: float) -> void:
	if not is_enabled or entity.is_on_floor():
		return
	entity.velocity.y -= (gravity * gravity_scale) * delta
