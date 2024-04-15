extends CharacterBody2D
class_name Sheep


@onready var draggable: Draggable = $"Draggable"
@onready var sprite: SpriteLeftRight = $"Sprite"
@onready var drag_sound: AudioStreamPlayer2D = $"Draggable/DragSound"
@onready var drop_sound: AudioStreamPlayer2D = $"Draggable/DropSound"


func _on_move(movement: Vector2) -> void:
	move_and_collide(movement)
	sprite.handle_move(movement)

func _on_draggable_dragged() -> void:
	drag_sound.play()

func _on_draggable_dropped() -> void:
	drop_sound.play()
