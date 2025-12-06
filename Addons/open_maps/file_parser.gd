extends Node


func parse_osm_file() -> void:
	var parser = XMLParser.new()
	while parser.read() != ERR_FILE_EOF:
		if parser.get_node_type() == XMLParser.NODE_ELEMENT:
			var node_name = parser.get_node_name()
			var attr = {}
			for idx in range(parser.get_attribute_count()):
				attr[parser.get_attribute_name(idx)] = parser.get_attribute_value(idx)
			
