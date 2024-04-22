extends Node
class_name Inventory


signal new_counter_created(kind: StringName, counter: Counter)


@export var counter_scene: PackedScene


func get_counter(kind: StringName) -> Counter:
	var path: NodePath = NodePath(kind)
	var counter: Counter = get_node_or_null(path)
	if counter != null:
		return counter
	counter = counter_scene.instantiate()
	counter.name = kind 
	add_child(counter)
	new_counter_created.emit(kind, counter)
	return counter
