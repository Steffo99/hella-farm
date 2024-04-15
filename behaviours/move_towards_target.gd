extends Node2D
class_name MoveTowardsTarget


signal move(movement: Vector2)


@export var speed: float = 100.0
@export var target: Node2D


func get_followed_global_position():
	return target.global_position


func get_followed_mouse_position():
	var global_followed_position: Vector2 = get_followed_global_position()
	var relative_followed_position: Vector2 = global_followed_position - global_position
	return relative_followed_position


func _physics_process(delta: float) -> void:
	if target == null:
		return
	var relative_followed_position: Vector2 = get_followed_mouse_position()
	var direction: Vector2 = position.direction_to(relative_followed_position)
	var actual_speed: float = min(delta * speed, relative_followed_position.length())  # Don't overshoot.
	var movement: Vector2 = direction * actual_speed
	move.emit(movement)
