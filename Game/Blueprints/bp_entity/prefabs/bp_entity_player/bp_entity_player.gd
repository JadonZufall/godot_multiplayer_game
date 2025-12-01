extends Entity


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
