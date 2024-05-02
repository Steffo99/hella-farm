extends Entity
class_name Watcher


func _on_dragged(_cursor: Cursor) -> void:
	set_flying()
	animator.play(&"drag_start")

func _on_fallen() -> void:
	set_flying()
	animator.play(&"RESET")

func _on_trapped() -> void:
	set_trapped()

func _on_freed() -> void:
	set_flying()

func _on_gold_spawner_spawned(entity:Node2D) -> void:
	entity.get_node("MoveStraight").speed = 50
	entity.get_node("MoveStraight").randomize_direction()
	entity.get_node("MoveStraight/Priority").priority_alternative()
