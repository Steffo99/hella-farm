@icon("res://behaviours/move_towards.svg")
extends Node2D
class_name MoveTowards


## A node emitting the [signal move] signal each physics timestep to move towards the position of [field target].


signal move(norm: Vector2)


@export var target: Node2D = null


func set_target(value: Node2D) -> void:
	target = value

func clear_target() -> void:
	target = null


func _ready() -> void:
	if target == null:
		Log.w(self, "No target is set, no signals will be emitted.")

func _physics_process(_delta: float) -> void:
	if target:
		var gap = target.global_position - global_position
		var norm = gap.normalized()
		move.emit(norm)	
