extends Node2D
class_name MoveTowardsMouse


signal move(movement: Vector2)
signal detached
signal captured

@onready var game := MainGame.get_ancestor(self)

@export var speed: float = 100.0
@export var can_detach: bool = false

@export var state_holder: StateHolder
@export var state_name: StringName = ''


var is_captured: bool :
	get: 
		return state_holder.state == state_name

func get_followed_global_position():
	return game.camera.get_global_mouse_position()


func get_followed_mouse_position():
	var global_followed_position: Vector2 = get_followed_global_position()
	var relative_followed_position: Vector2 = global_followed_position - global_position
	return relative_followed_position


func _ready():
	if state_holder == null:
		if state_name == '':
			state_holder = StateHolder.new()
		else:
			state_holder = StateHolder.get_default(self)

func _physics_process(delta: float) -> void:
	if is_captured:
		var relative_followed_position: Vector2 = get_followed_mouse_position()
		var direction: Vector2 = position.direction_to(relative_followed_position)
		var actual_speed: float = min(delta * speed, relative_followed_position.length())  # Don't overshoot.
		var movement: Vector2 = direction * actual_speed
		move.emit(movement)

func _on_capture_area_mouse_entered() -> void:
	if state_holder.propose_state(state_name, 70, func (): detached.emit()):
		captured.emit()

func _on_capture_area_mouse_exited() -> void:
	if can_detach:
		state_holder.remove_state(state_name)
		

