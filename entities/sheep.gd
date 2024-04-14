extends CharacterBody2D
class_name Sheep


@onready var draggable: Draggable = $"Draggable"


func _on_move(movement: Vector2) -> void:
	if not draggable.being_dragged:
		move_and_collide(movement)


func _on_drag_move(movement: Vector2) -> void:
	if draggable.being_dragged:
		move_and_collide(movement)
