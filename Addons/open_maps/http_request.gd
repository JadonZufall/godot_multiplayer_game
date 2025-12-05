@tool
extends HTTPRequest


func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print("%d %d [")
	for i in headers:
		print(i)
	
	var filepath: String = "C:/Users/jadon/Projects/Godot/godot_multiplayer_game/Downloads/map_output.xml"
	var file: FileAccess = FileAccess.open(filepath, FileAccess.WRITE)
	file.store_buffer(body)
	file.close()
	print("Saved to ", filepath)


func _on_request_pressed() -> void:
	request("https://www.openstreetmap.org/api/0.6/map?bbox=-85.68926%2C42.73221%2C-85.62296%2C42.74186")
