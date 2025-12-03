extends Component

@export var is_enabled: bool = true
@export var cur_health: float = 100.0
@export var max_health: float = 100.0

signal damage(amount: float)

func _ready() -> void:
	super._ready()
	
	
