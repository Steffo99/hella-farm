extends BetterCharacterBody2D
class_name Monocle


@onready var animator: AnimationPlayer = %"Animator"


func _on_move(movement: Vector2) -> void:
	better_move_and_collide(movement)

func _on_dragged(_cursor: Cursor) -> void:
	collision_layer = 16
	collision_mask = 18
	z_index = 1
	animator.play(&"drag_start")

func _on_fallen() -> void:
	collision_layer = 8
	collision_mask = 14
	z_index = 0
	animator.play(&"RESET")
