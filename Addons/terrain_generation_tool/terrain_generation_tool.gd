@tool
extends EditorPlugin

const EDITOR_SCENE: PackedScene = preload("res://Addons/terrain_generation_tool/terrain_generation_tool.tscn")
var editor_instance: Window

func _enter_tree() -> void:
	editor_instance = EDITOR_SCENE.instantiate()
	editor_instance.hide()
	get_editor_interface().get_base_control().add_child(editor_instance)
	add_tool_menu_item("Open Terrain Editor", Callable(self, "_on_open_editor_window"))

func _on_open_editor_window() -> void:
	editor_instance.popup_centered()

func _exit_tree() -> void:
	remove_tool_menu_item("Open Terrain Editor")
	editor_instance.queue_free()
