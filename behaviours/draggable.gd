@icon("res://behaviours/draggable.svg")
extends Area2D
class_name Draggable


signal dragged
signal dropped


var being_dragged: bool = false


func drag():
	being_dragged = true
	dragged.emit()

func drop():
	being_dragged = false
	dropped.emit()
