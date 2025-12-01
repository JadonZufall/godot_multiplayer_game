@tool
extends Window

@export var mesh: TerrainGenerator3D
@export var camera: Camera3D
@export var viewport: SubViewport


func _on_close_requested() -> void:
	hide()

func _on_content_mesh_size_value_modified(value: Vector2) -> void:
	pass # Replace with function body.


func _on_viewport_wireframe_toggled(toggled_on: bool) -> void:
	if toggled_on:
		viewport.debug_draw = SubViewport.DEBUG_DRAW_WIREFRAME
	else:
		viewport.debug_draw = SubViewport.DEBUG_DRAW_DISABLED
