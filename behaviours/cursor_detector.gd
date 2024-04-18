@icon("res://behaviours/cursor_detector.svg")
extends Area2D
class_name CursorDetector


signal cursor_entered(cursor: Cursor)
signal cursor_exited(cursor: Cursor)


var mouse_inside = false


func _on_body_entered(body: Node2D) -> void:
	if body is Cursor:
		mouse_inside = true
		cursor_entered.emit(body)

func _on_body_exited(body: Node2D) -> void:
	if body is Cursor:
		mouse_inside = true
		cursor_exited.emit(body)

func log_cursor(cursor: Cursor) -> void:
	Log.p(self, "Cursor: %s" % cursor)
