@icon("res://behaviours/move.svg")
extends Move
class_name MoveStraight


## A [Move] that moves in a fixed direction.


@export var direction: Vector2


func randomize_direction() -> void:
	direction = Vector2.from_angle(Random.rng.randf_range(0, 2*PI))


func _physics_process(_delta: float) -> void:
	move.emit(direction)
