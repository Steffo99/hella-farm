@icon("res://behaviours/spawner.svg")
extends Node2D
class_name Spawner


## Emitted when a new scene is spawned.
signal spawned(entity: Node2D)

## Emitted when the [field blocking_tracker] prevents something from spawning.
signal spawn_blocked


## The scene to spawn.
@export var scene: PackedScene

## Where the scene should be parented to in the tree.
@export var target: Node2D

## If set, requires the tracker to not be tracking anything before spawning a scene.
@export var blocking_tracker: Tracker


## Spawn [field scene] at [field target] and the position of this node.
func spawn():
	if blocking_tracker != null:
		if not blocking_tracker.tracking.is_empty():
			spawn_blocked.emit()
			return  # Perhaps enqueue the spawn?
	if not target:
		target = MainGame.get_via_group(self).default_spawn_parent
	if not target:
		target = self
	if not scene:
		Log.w(self, "Not spawning, no scene is set.")
		return
	var entity = scene.instantiate()
	entity.global_scale = global_scale
	entity.global_position = global_position
	entity.global_rotation = global_rotation
	target.add_child.call_deferred(entity)  # Not sure why this is needed.
