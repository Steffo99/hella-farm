extends ColorRect
class_name PostprocessingRect


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed(&"postprocessing_toggle"):
			visible = !visible