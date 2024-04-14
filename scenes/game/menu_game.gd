extends Node2D
class_name MainGame


## Get the first possible [MainGame] instance by climbing the scene tree one ancestor at a time.
static func get_ancestor(start: Node) -> MainGame:
	var current = start
	while current is Node:
		if current is MainGame:
			return current
		current = current.get_parent()
	return null


@onready var gold_counter: Counter = $"GoldCounter"
