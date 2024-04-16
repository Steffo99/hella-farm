@icon("res://behaviours/priority.svg")
extends Node
class_name Priority


@export var priority: int = 0


func get_ref() -> Node:
	return get_parent()
