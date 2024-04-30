extends Sprite2D
class_name SpriteLeftRight


@export var left_texture: Texture2D
@export var right_texture: Texture2D

var last_discrim: float = 0

func handle_move(movement: Vector2):
	var discrim = movement.x 
	if discrim == 0:
		discrim = last_discrim
	if discrim > 0:
		texture = right_texture
		for child in get_children():
			child.scale.x = -abs(child.scale.x)
		last_discrim = discrim
	elif discrim < 0:
		texture = left_texture
		for child in get_children():
			child.scale.x = abs(child.scale.x)
		last_discrim = discrim
