@icon("res://behaviours/spawner.svg")
extends Node2D
class_name Spawner


## Emitted when a new scene is spawned.
signal spawned(entity: Node2D)

## Emitted when a spawn fails due to the spawner being disabled.
signal spawn_blocked


## The scene to spawn.
@export var scene: PackedScene

## Where the scene should be parented to in the tree.
@export var target: Node2D

## Whether calling [method spawn] does instantiate a scene.
@export var enabled: bool = true


func enable():
	enabled = true

func disable():
	enabled = false

## Spawn [field scene] at [field target] and the position of this node.
func spawn():
	if not enabled:
		spawn_blocked.emit()
		return null
	if not target:
		target = MainGame.get_via_group(self).default_spawn_parent
	if not target:
		target = self
	if not scene:
		Log.w(self, "Not spawning, no scene is set.")
		return null
	var entity = scene.instantiate()
	entity.global_position = global_position
	target.add_child.call_deferred(entity)
	spawned.emit(entity)
	return entity

func roll_spawn(odds: int):
	if Random.rng.randi_range(0, odds - 1) == 0:
		spawn()

func log_spawned(entity: Node2D) -> void:
	Log.p(self, "Spawned: %s" % entity)
