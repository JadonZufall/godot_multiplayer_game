extends RigidBody3D
@onready var synchronizer: MultiplayerSynchronizer = $synchronizer
@onready var authority_timer: Timer = $synchronizer/authority_timer


func _ready() -> void:
	authority_timer.timeout.connect(reassign_authority)

func _process(delta: float) -> void:
	pass

func reassign_authority() -> void:
	pass

func get_closest_player() -> Entity:
	var closest_distance: float = INF
	var closest_player: Entity
	for node in get_tree().get_nodes_in_group("Players"):
		if node is not Entity:
			continue
		var entity: Entity = node as Entity
		var distance: float = entity.global_position.distance_squared_to(global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_player = entity
	return closest_player
