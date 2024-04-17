@icon("res://behaviours/sampler.svg")
extends Node
class_name Sampler


## Abstract base class for sampling a certain reference among multiple.


signal notify_selected(node: Node)
signal notify_deselected(node: Node)


@export var possibilities: Array[Node] = []


## Get a reference.
func sample() -> Node:
	Log.e(self, "Not implemented.")
	return null

## Get all possible nodes referenced by [field possibilities].
func get_refs() -> Array[Node]:
	return possibilities

## Set the "enabled" property on 
func enable() -> void:
	var selected = sample()
	for possibility in get_refs():
		possibility.enabled = (selected == possibility)
