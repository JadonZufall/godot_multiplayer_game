@tool
extends EditorScript


func _run() -> void:
	var scale_factor: float = 2.0
	var editor_interface: EditorInterface = get_editor_interface()
	var selection: Array[Node] = editor_interface.get_selection().get_selected_nodes()
	var undo_redo: EditorUndoRedoManager = editor_interface.get_editor_undo_redo()
	undo_redo.create_action("tool_model_child_scale")
	if selection.is_empty():
		print("Please select nodes")
		return
	
	for node in selection:
		if node is not Node3D:
			continue
		
		var target: Node3D = node as Node3D
		
		var initial_pos: Vector3 = target.position
		var initial_scale: Vector3 = target.scale
		var scaled_pos: Vector3 = initial_pos * scale_factor
		var scaled_scale: Vector3 = initial_scale * scale_factor
		
		undo_redo.add_do_property(node, "scale", scaled_scale)
		undo_redo.add_do_property(node, "position", scaled_pos)
		undo_redo.add_undo_property(node, "scale", initial_scale)
		undo_redo.add_undo_property(node, "position", initial_pos)
	undo_redo.commit_action()
	print("Child Scale Complete")
