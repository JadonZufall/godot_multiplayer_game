@tool
class_name TerrainGenerator3D extends MeshInstance3D

@export var noise: NoiseTexture2D
@export var height: float = 10.0
@export var default_size: Vector2 = Vector2(10, 10)

func _ready() -> void:
	mesh = ArrayMesh.new()

@export_tool_button("Generate Flat") var action_generate_flat: Callable = _generate_flat
func _generate_flat() -> void:
	generate_flat_array_mesh(default_size)


func generate_flat_array_mesh(size: Vector2) -> void:
	# Create new array mesh.
	var a_mesh: ArrayMesh = ArrayMesh.new()
	
	noise.width = size.x
	noise.height = size.y
	
	# Each vertex represents a point.
	var vertices: Array[Vector3] = []
	for z in range(0, size.y):
		for x in range(0, size.x):
			var centered_x: float = float(x) - ((size.x - 1) / 2)
			var centered_z: float = float(z) - ((size.y - 1) / 2)
			
			var scaled_y: float = noise.noise.get_noise_2d(x, z) * height
			
			# TODO: Read from height map to get proper height.
			vertices.append(Vector3(centered_x, scaled_y, centered_z))
	
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
	
	# TODO: Generate normals
	var normals: Array[Vector3] = []
	normals.resize(vertices.size())
	for index in range(0, vertices.size()):
		normals[index] = Vector3.ZERO
	
	for i in range(0, indices.size(), 3):
		var idx_a = indices[i]
		var idx_b = indices[i+1]
		var idx_c = indices[i+2]
		
		var a: Vector3 = vertices[idx_a]
		var b: Vector3 = vertices[idx_b]
		var c: Vector3 = vertices[idx_c]
		
		var edge_a = b - a
		var edge_b = c - a
		var face_normal = edge_a.cross(edge_b).normalized()
		
		normals[idx_a] += face_normal
		normals[idx_b] += face_normal
		normals[idx_c] += face_normal
		
	
	# Pack data
	var packed_vertices: PackedVector3Array = PackedVector3Array(vertices)
	var packed_indices: PackedInt32Array = PackedInt32Array(indices)
	var packed_uvs: PackedVector2Array = PackedVector2Array(uvs)
	var packed_normals: PackedVector3Array = PackedVector3Array(normals)
	
	# Create data for array mesh
	var array: Array = []
	array.resize(Mesh.ARRAY_MAX)
	
	# Append data to the data for array mesh
	array[Mesh.ARRAY_VERTEX] = packed_vertices
	array[Mesh.ARRAY_INDEX] = packed_indices
	#array[Mesh.ARRAY_TEX_UV] = packed_uvs
	array[Mesh.ARRAY_NORMAL] = packed_normals
	
	# Add the data to the array mesh.
	a_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
	
	# Apply the array mesh.
	mesh = a_mesh
