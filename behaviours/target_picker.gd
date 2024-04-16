@icon("res://behaviours/target_picker.svg")
extends Node
class_name TargetPicker


## Pick a random target at random from [field Tracker.tracked], then emit it via [signal target_changed].


signal target_changed(new: Node2D, old: Node2D)


@export var tracker: Tracker


var target: Node2D:
	get:
		return target
	set(value):
		if target != value:
			var old = target
			target = value
			target_changed.emit(old, target)


func set_target(body: Node2D) -> void:
	target = body

func set_target_if_null(body: Node2D) -> void:
	if target == null:
		target = body

func clear_target() -> void:
	target = null

func clear_if_target(body: Node2D) -> void:
	if target == body:
		clear_target()

func sample_target() -> void:
	target = Random.sample(tracker.tracking)

func sample_target_if_null() -> void:
	if target == null:
		sample_target()
