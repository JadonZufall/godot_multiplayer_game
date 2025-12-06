extends VBoxContainer


@export var tree_item: PackedScene
var data: Dictionary[String, Node] = {}

func _ready() -> void:
	var root: Window = get_tree().get_root()
	_add_node(root)
	_recursive_node_tree_build.call_deferred(root)

func _recursive_node_tree_build(node: Node) -> void:
	# Don't build a tree of the tree
	if node == self or is_ancestor_of(node):
		return
	
	for child in node.get_children():
		_add_node(child)
		_recursive_node_tree_build.call_deferred(child)

func _setup_item(node: Node, item: Node) -> void:
	item.get("item_name").text = node.name
	#item.get("item_icon").texture

func _add_node(node: Node) -> void:
	var item: Node = tree_item.instantiate()
	_setup_item.call_deferred(node, item)
	data.set(str(node.get_path()), item)
	
	var parent: Node = node.get_parent()
	if not parent:
		add_child(item)
	else:
		var parent_item: Node = data.get(str(parent.get_path()))
		var parent_children: Node = parent_item.get("item_children")
		parent_children.add_child(item)
	
	
	
