@icon("res://behaviours/spawner.svg")
extends Node2D
class_name Spawner

signal spawned(entity: Node2D)

@export var scene: PackedScene
@export var default_target: Node2D


func spawn(target: Node2D = null):
	if not target:
		target = default_target
	if not target:
		target = MainGame.get_ancestor(self).default_spawn_parent
	var entity = scene.instantiate()
	entity.global_scale = global_scale
	entity.global_position = global_position
	entity.global_rotation = global_rotation
	target.add_child.call_deferred(entity)  # Not sure why this is needed.
