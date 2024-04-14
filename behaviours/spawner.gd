extends Node2D
class_name Spawner

signal spawned(entity: Node2D)

@export var scene: PackedScene
@export var parent: Node2D

func spawn():
	var entity = scene.instantiate()
	entity.global_scale = global_scale
	entity.global_position = global_position
	entity.global_rotation = global_rotation
	parent.add_child(entity)

func _ready():
	if parent == null:
		parent = MainGame.get_ancestor(self).get_node("SpawnedEntities")

