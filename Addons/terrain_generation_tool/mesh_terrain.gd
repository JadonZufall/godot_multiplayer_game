@tool
class_name TerrainGenerator3D extends MeshInstance3D

@export_tool_button("Generate Flat") var action_generate_flat: Callable = _generate_flat
func _generate_flat() -> void:
	generate_flat_array_mesh(Vector2(10, 10))


func generate_flat_array_mesh(size: Vector2) -> void:
	# Create new array mesh.
	var a_mesh: ArrayMesh = ArrayMesh.new()
	
	# Each vertex represents a point.
	var vertices: Array[Vector3] = []
	for z in range(0, size.y):
		for x in range(0, size.x):
			var centered_x: float = float(x) - ((size.x - 1) / 2)
			var centered_z: float = float(z) - ((size.y - 1) / 2)
			print("%d, %d" % [centered_x, centered_z])
			# TODO: Read from height map to get proper height.
			vertices.append(Vector3(centered_x, 0, centered_z))
	
	# Each index references the vertices array.
	var indices: Array[int] = []
	for z in range(0, size.y):
		for x in range(0, size.x):
			var index: int = (z * size.x) + x
			
			# Ensure the next point is in the same row as the point.
			if floor(index / size.x) == floor((index + 1) / size.x):
				# Ensure the point on the next line is not out of bounds.
				if (index + size.x) < vertices.size():
					indices.append_array([index, index + 1, index + int(size.x)])    # Front Face
					indices.append_array([index, index + int(size.y), index + 1])    # Back Face
			
			# Ensure the previous point is in the same row as the point.
			if floor(index / size.x) == floor((index - 1) / size.x):
				# Ensure the point on the prev line is not out of bounds.
				if (index - size.x) >= 0:
					indices.append_array([index, index - 1, index - int(size.x)])    # Front Face
					indices.append_array([index, index - int(size.x), index - 1])    # Back Face
	
	# Each uv corrisponds to r and g channels to uv map, 0.0-1.0
	var uvs: Array[Vector2] = []
	for vertex in vertices:
		pass
	
	
	# Pack data
	var packed_vertices: PackedVector3Array = PackedVector3Array(vertices)
	var packed_indices: PackedInt32Array = PackedInt32Array(indices)
	var packed_uvs: PackedVector2Array = PackedVector2Array(uvs)
	
	# Create data for array mesh
	var array: Array = []
	array.resize(Mesh.ARRAY_MAX)
	
	# Append data to the data for array mesh
	array[Mesh.ARRAY_VERTEX] = packed_vertices
	array[Mesh.ARRAY_INDEX] = packed_indices
	#array[Mesh.ARRAY_TEX_UV] = packed_uvs
	
	# Add the data to the array mesh.
	a_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
	
	# Apply the array mesh.
	mesh = a_mesh
