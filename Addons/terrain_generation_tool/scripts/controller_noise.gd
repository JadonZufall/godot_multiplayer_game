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
var noise_texture: NoiseTexture2D
var noise: FastNoiseLite


func _ready() -> void:
	noise_texture = noise_texture_rect.texture
	noise = noise_texture.noise


func _on_content_noise_opt_offset_value_modified(value: Vector3) -> void:
	noise.offset = value

func _on_content_mesh_size_value_modified(value: Vector2) -> void:
	noise_texture.width = value.x
	noise_texture.height = value.y

func _on_content_noise_opt_seed_value_modified(value: int) -> void:
	noise.seed = value
