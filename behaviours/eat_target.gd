extends Node2D
class_name EatTarget


signal eaten(target: Node2D)
signal move(movement: Vector2)

@export var tag: StringName:
	get:
		return tag
	set(value):
		tag = value
		if hunt_target != null:
			hunt_target.tag = value
		if eater != null:
			eater.tag = value


@onready var hunt_target: HuntTarget = $"HuntTarget"
@onready var eater: Eater = $"Eater"
@onready var move_towards: MoveTowardsTarget = $"MoveTowardsTarget"

func _ready():
	hunt_target.tag = tag
	eater.tag = tag

func _on_target_selected(body: Node2D) -> void:
	move_towards.target = body

func _on_target_abandoned(_body: Node2D) -> void:
	move_towards.target = null


func _on_eater_eaten(edible):
	eaten.emit(edible)


func _on_move_towards_target_move(movement):
	move.emit(movement)
