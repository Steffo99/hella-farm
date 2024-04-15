extends Node2D
class_name MoveTowardsMouse


signal move(movement: Vector2)
signal detached
signal captured

@onready var game := MainGame.get_ancestor(self)

@export var speed: float = 100.0
@export var can_detach: bool = false


enum State { DETACHED, CAPTURED }

var state: State = State.DETACHED

func get_followed_global_position():
	return game.camera.get_global_mouse_position()


func get_followed_mouse_position():
	var global_followed_position: Vector2 = get_followed_global_position()
	var relative_followed_position: Vector2 = global_followed_position - global_position
	return relative_followed_position


func _physics_process(delta: float) -> void:
	match state:
		State.CAPTURED:
			var relative_followed_position: Vector2 = get_followed_mouse_position()
			var direction: Vector2 = position.direction_to(relative_followed_position)
			var actual_speed: float = min(delta * speed, relative_followed_position.length())  # Don't overshoot.
			var movement: Vector2 = direction * actual_speed
			move.emit(movement)

func _on_capture_area_mouse_entered() -> void:
	state = State.CAPTURED
	captured.emit()

func _on_capture_area_mouse_exited() -> void:
	if can_detach:
		state = State.DETACHED
		detached.emit()

