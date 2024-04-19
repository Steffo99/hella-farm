@icon("res://behaviours/spawner.svg")
extends Area2D
class_name Spawner

signal spawned(entity: Node2D)

@export var scene: PackedScene
@export var target: Node2D


func spawn():
	if not target:
		target = MainGame.get_ancestor(self).default_spawn_parent
	if not target:
		target = self
	var entity = scene.instantiate()
	entity.global_scale = global_scale
	entity.global_position = global_position
	entity.global_rotation = global_rotation
	target.add_child.call_deferred(entity)  # Not sure why this is needed.
