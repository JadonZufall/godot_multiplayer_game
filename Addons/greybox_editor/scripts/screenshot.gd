@tool
extends Button

@export var sub_viewport: SubViewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	print("Screenshot")
	var screen_shot_w: int = 512
	var screen_shot_h: int = 512
	var image: Image = sub_viewport.get_texture().get_image()
	print(image.get_size())
	var p1: Vector2 = Vector2(
		image.get_width() / 2 - screen_shot_w / 2,
		image.get_height() / 2 - screen_shot_h / 2
	)
	var p2: Vector2 = Vector2(
		image.get_width() / 2 + screen_shot_w / 2,
		image.get_height() / 2 + screen_shot_h / 2
	)
	image = image.get_region(Rect2(p1, p2 - p1))
	image.resize(256, 256)
	image.save_png("res://Addons/greybox_editor/screenshots/screenshot.png")
	EditorInterface.get_resource_filesystem().scan()
