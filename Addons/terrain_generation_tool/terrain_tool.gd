@tool
extends Window

@export var mesh: TerrainGenerator3D
@export var camera: Camera3D
@export var viewport: SubViewport
@export var noise: TextureRect

func _ready() -> void:
	mesh.noise = noise.texture


func _on_close_requested() -> void:
	hide()

func _on_viewport_wireframe_toggled(toggled_on: bool) -> void:
	if toggled_on:
		viewport.debug_draw = SubViewport.DEBUG_DRAW_WIREFRAME
	else:
		viewport.debug_draw = SubViewport.DEBUG_DRAW_DISABLED


func _on_button_generate_terrain_pressed() -> void:
	mesh.generate_array_mesh(noise.texture.get_size())
