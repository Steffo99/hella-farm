extends CharacterBody2D
class_name Imp


@onready var sprite: SpriteLeftRight = $"Sprite"


func _on_move(movement:Vector2):
	move_and_collide(movement)
	sprite.handle_move(movement)
