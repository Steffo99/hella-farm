extends Area2D
class_name HoverDetector


var mouse_inside = false


func _on_mouse_entered() -> void:
	mouse_inside = true

func _on_mouse_exited() -> void:
	mouse_inside = false
