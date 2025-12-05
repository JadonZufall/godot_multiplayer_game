extends Tree

func recursive_build(parent: Node, item: TreeItem, depth: int=0) -> void:
	for child in parent.get_children():
		var entry: TreeItem = create_item(item)
		entry.set_text(depth, child.name)
		recursive_build(child, item)


func _ready() -> void:
	var root: Window = get_tree().get_root()
	var root_entry: TreeItem = create_item()
	root_entry.set_text(0, root.name)
	recursive_build(root, root_entry)


func _process(delta: float) -> void:
	pass
