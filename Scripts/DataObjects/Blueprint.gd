class_name Blueprint extends Resource

enum BlueprintType { NONE, ENTITY, SCENE, DEBUG }

@export var _name: String
@export var _scene: PackedScene
@export var _type: BlueprintType
