extends CharacterBody2D
class_name Sheep


@onready var sprite: SpriteLeftRight = $"Sprite"
@onready var animator: AnimationPlayer = $"Animator"


func _ready() -> void:
	animator.play("RESET")

func _on_move(movement: Vector2) -> void:
	move_and_collide(movement)
	sprite.handle_move(movement)

func _on_dragged(_cursor: Cursor) -> void:
	collision_layer = 16
	collision_mask = 18
	z_index = 1

func _on_fallen() -> void:
	collision_layer = 8
	collision_mask = 14
	z_index = 0
