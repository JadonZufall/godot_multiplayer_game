@tool
extends PanelContainer

@export var opt_seed: PanelContainer
@export var opt_offset: PanelContainer
@export var opt_normalize: PanelContainer
@export var opt_seemless: PanelContainer
@export var opt_invert: PanelContainer
@export var opt_frequency: PanelContainer
@export var opt_type: PanelContainer

@export var noise_texture_rect: TextureRect



func _on_content_noise_opt_offset_value_modified(value: Vector3) -> void:
	noise_texture_rect.texture.noise.offset = value

func _on_content_mesh_size_value_modified(value: Vector2) -> void:
	noise_texture_rect.texture.width = value.x
	noise_texture_rect.texture.height = value.y

func _on_content_noise_opt_seed_value_modified(value: int) -> void:
	noise_texture_rect.texture.noise.seed = value
