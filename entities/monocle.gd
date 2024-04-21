extends CharacterBody2D
class_name Monocle


func _on_move(movement: Vector2) -> void:
	move_and_collide(movement)
