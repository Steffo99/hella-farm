@icon("res://behaviours/draggable.svg")
extends Area2D
class_name Draggable


signal dragged(cursor: Cursor)
signal dropped


var being_dragged: bool = false


func drag(cursor: Cursor):
	being_dragged = true
	dragged.emit(cursor)

func drop():
	being_dragged = false
	dropped.emit()
