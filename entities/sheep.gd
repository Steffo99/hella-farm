extends CharacterBody2D
class_name Sheep


@onready var sprite: SpriteLeftRight = $"Sprite"
@onready var animator: AnimationPlayer = $"Animator"


func _ready() -> void:
	animator.play("RESET")

func _on_move(movement: Vector2) -> void:
	move_and_collide(movement)
	sprite.handle_move(movement)


func _on_draggable_dragged() -> void:
	collision_layer = 16

func _on_draggable_dropped() -> void:
	collision_layer = 8
