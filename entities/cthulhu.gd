extends Entity
class_name Cthulhu


func _on_dragged(_cursor: Cursor) -> void:
	set_flying()
	animator.play(&"drag_start")

func _on_fallen() -> void:
	set_grounded()
	animator.play(&"RESET")

func _on_gold_spawner_spawned(entity:Node2D) -> void:
	entity.scale *= 2
	entity.get_node("Collectible").quantity = 25
	entity.get_node("MoveStraight").randomize_direction()
	entity.get_node("MoveStraight/Priority").priority_alternative()
