extends Entity
class_name TopHat


func _on_dragged(_cursor: Cursor) -> void:
	set_flying()
	animator.play(&"drag_start")

func _on_fallen() -> void:
	set_grounded()
	animator.play(&"RESET")

func _on_trapped() -> void:
	set_trapped()

func _on_freed() -> void:
	set_grounded()
