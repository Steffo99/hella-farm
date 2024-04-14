extends Node2D
class_name MoveTowardsMouse


signal move(movement: Vector2)
signal captured


@export_range(-5, 5, 1) var speed := 1.0

@onready var viewport: Viewport = get_viewport()


enum State { STILL, CAPTURED }

var state: State = State.STILL


func get_relative_mouse_position():
	var viewport_position: Vector2 = viewport.position 
	var viewport_mouse_position: Vector2 = viewport.get_mouse_position()
	var global_mouse_position: Vector2 = viewport_position + viewport_mouse_position
	var relative_mouse_position: Vector2 = global_mouse_position - global_position
	return relative_mouse_position


func _physics_process(delta: float) -> void:
	match state:
		State.CAPTURED:
			var direction: Vector2 = position.direction_to(get_relative_mouse_position())
			var movement: Vector2 = direction * delta * speed
			move.emit(movement)

func _on_capture_area_mouse_entered() -> void:
	state = State.CAPTURED
	captured.emit()
