extends Area2D
class_name Draggable


signal move(movement: Vector2)
signal dragged
signal dropped


@onready var mover: Node2D = $"MatchMousePosition"

var being_dragged: bool:
	get:
		return being_dragged
	set(value):
		being_dragged = value
		mover.set_process(being_dragged)
		mover.set_physics_process(being_dragged)


func drag():
	being_dragged = true
	dragged.emit()

func drop():
	being_dragged = false
	dropped.emit()


func _ready():
	being_dragged = false

func _on_move(movement: Vector2):
	move.emit(movement)
