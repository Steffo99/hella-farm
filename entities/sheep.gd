extends CharacterBody2D
class_name Sheep


@onready var draggable: Draggable = $"Draggable"
@onready var drag_sound: AudioStreamPlayer2D = $"Draggable/DragSound"
@onready var drop_sound: AudioStreamPlayer2D = $"Draggable/DropSound"


func _on_move(movement: Vector2) -> void:
	if not draggable.being_dragged:
		move_and_collide(movement)

func _on_drag_move(movement: Vector2) -> void:
	if draggable.being_dragged:
		move_and_collide(movement)

func _on_draggable_dragged() -> void:
	drag_sound.play()

func _on_draggable_dropped() -> void:
	drop_sound.play()
