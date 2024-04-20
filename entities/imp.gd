extends CharacterBody2D
class_name Imp


@onready var sprite: SpriteLeftRight = $"Sprite"
@onready var eater: Eater = $"Eater"


func _on_move(movement: Vector2):
	move_and_collide(movement)
	sprite.handle_move(movement)

func _on_eater_eaten(edible: Edible) -> void:
	edible.get_parent().queue_free()


func _on_draggable_dragged(_cursor: Cursor) -> void:
	collision_layer = 16
	collision_mask = 18
	z_index = 1
	eater.collision_mask = 16

func _on_draggable_dropped() -> void:
	collision_layer = 8
	collision_mask = 14
	z_index = 0
	eater.collision_mask = 8
