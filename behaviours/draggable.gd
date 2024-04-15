extends Area2D
class_name Draggable


signal move(movement: Vector2)
signal dragged
signal dropped

@export var state_holder: StateHolder

@onready var mover: Node2D = $"MatchMousePosition"

var is_being_dragged: bool:
	get:
		return state_holder.state == 'dragged'


func drag():
	if not state_holder.propose_state('dragged', 100, _on_dropped):
		return false
	
	_update_mover_process()
	dragged.emit()

func drop():
	state_holder.remove_state('dragged')

func _on_dropped():
	dropped.emit()

func _update_mover_process():
	var value = is_being_dragged
	mover.set_process(value)
	mover.set_physics_process(value)

func _ready():
	if state_holder == null:
		state_holder = StateHolder.get_default(self)
	_update_mover_process()

func _on_move(movement: Vector2):
	if is_being_dragged:
		move.emit(movement)
