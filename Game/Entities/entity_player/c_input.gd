extends Component

@export var is_enabled: bool = false

var jump: bool = false
var move: Vector2 = Vector2.ZERO

func _process_update_authority(_delta: float) -> void:
	if not is_enabled:
		move = Vector2.ZERO
		return
	
	move = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	jump = Input.is_action_just_pressed("action_jump")
