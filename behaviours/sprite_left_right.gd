extends Sprite2D
class_name SpriteLeftRight


@export var left_texture: Texture2D
@export var right_texture: Texture2D


func handle_move(movement: Vector2):
	if movement.x > 0:
		texture = right_texture
	else:
		texture = left_texture
