extends CharacterBody2D
class_name Sheep


@onready var sprite: SpriteLeftRight = $"Sprite"
@onready var drag_sound: AudioStreamPlayer2D = $"Draggable/DragSound"
@onready var drop_sound: AudioStreamPlayer2D = $"Draggable/DropSound"
@onready var animator: AnimationPlayer = $"Animator"


func _ready() -> void:
	animator.play("RESET")

func _on_move(movement: Vector2) -> void:
	move_and_collide(movement)
	sprite.handle_move(movement)
