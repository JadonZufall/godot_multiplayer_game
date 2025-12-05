extends VBoxContainer

@onready var expand_btn: CheckButton = $item_content/expand_btn
@onready var item_name: Label = $item_content/content_margin/item_description/item_name
@onready var item_icon: TextureRect = $item_content/content_margin/item_description/item_icon
@onready var item_children: VBoxContainer = $item_children_margin/item_children


func _ready() -> void:
	if not expand_btn.button_pressed:
		item_children.hide()
	else:
		item_children.show()
	
	if item_children.get_child_count() == 0:
		expand_btn.hide()
	else:
		expand_btn.show()

func _on_expand_btn_toggled(toggled_on: bool) -> void:
	if toggled_on:
		item_children.show()
	else:
		item_children.hide()


func _on_item_children_child_entered_tree(node: Node) -> void:
	if item_children.get_child_count() == 0:
		expand_btn.hide()
	else:
		expand_btn.show()

func _on_item_children_child_exiting_tree(node: Node) -> void:
	if item_children.get_child_count() == 0:
		expand_btn.hide()
	else:
		expand_btn.show()
