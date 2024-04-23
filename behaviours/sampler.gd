@icon("res://behaviours/sampler.svg")
extends Node
class_name Sampler


## Abstract base class for sampling a certain reference among multiple.


## [Array] of [Node]s that can be [func sample]d by this [Sampler].
@export var possibilities: Array[Node] = []

## If true, the [Sampler] will attempt to automatically [method sample_and_enable] on NOTIFICATION_READY.
@export var autoenable_on_ready: bool = true


var selected: Node = null;


## Get a reference.
func sample() -> Node:
	Log.e(self, "Not implemented.")
	return null

## Set the [field enabled] property to true on a [method sample]d node, and to false on all others. 
func sample_and_enable() -> void:
	set_enabled(sample())

func set_enabled(node: Node) -> void:
	if node == selected:
		return
	selected = node
	var selected_ref = get_ref(selected)
	for possibility in get_all_refs():
		possibility.enabled = (selected_ref == possibility)

func get_ref(node: Node) -> Node:
	return node

## Get all possible nodes referenced by [field possibilities].
##
## Useful as it may be overridden by some other [Sampler]s, such as [SamplerPriority].
func get_all_refs() -> Array[Node]:
	return possibilities


func _ready() -> void:
	if autoenable_on_ready:
		sample_and_enable.call_deferred()
