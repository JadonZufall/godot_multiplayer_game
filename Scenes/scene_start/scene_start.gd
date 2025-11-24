extends Control

@export var switch_to_scene_on_start: PackedScene

@rpc("any_peer", "call_local")
func change_to_scene() -> void:
	get_node("/root/SceneLoader/3D World").call_deferred("add_child", switch_to_scene_on_start.instantiate())
	queue_free()
	

func _on_btn_start_pressed() -> void:
	rpc("change_to_scene")
