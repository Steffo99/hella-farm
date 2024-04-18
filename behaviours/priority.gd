@icon("res://behaviours/priority.svg")
extends Node
class_name Priority


## Keeps track of the object's priority for [SamplerPriority] purposes.


## Emitted when the priority is changed.
signal priority_changed(new: int, old: int)

## Emitted when the priority is changed. No args are provided to work around a Godot bug.
signal priority_changed_no_args


@export var default_priority: int = 0
@export var alternative_priority: int = 1

var priority: int = 0:
	get:
		return priority
	set(value):
		var old = priority
		priority = value
		priority_changed.emit(priority, old)


## Set [field priority] to [field default_priority].
func priority_default() -> void:
	priority = default_priority

## Set [field priority] to [field alternative_priority]
func priority_alternative() -> void:
	priority = alternative_priority

## Toggle [field priority] between [field default_priority] and [field alternative_priority].
func priority_toggle() -> void:
	if priority == default_priority:
		priority = alternative_priority
	else:
		priority = default_priority

## Set the [field priority] to a specific value.
func priority_set(value: int):
	priority = value

## Set the [field priority] to a specific value if the [param variant] is truthy, otherwise set it to a different value.
## 
## Defaults to using [field alternative_priority] for truthy, and [field default_priority] for falsy
func priority_conditional(variant: Variant, truthy: int = alternative_priority, falsy: int = default_priority):
	if variant:
		priority = truthy
	else:
		priority = falsy

## Get the node to which the [field priority] of this one applies to.
func get_ref() -> Node:
	return get_parent()

## Log the current [field priority] value.
func log_priority() -> void:
	Log.p(self, "Priority: %d" % priority)


func _on_priority_changed(_new: int, _old: int) -> void:
	priority_changed_no_args.emit()

func _ready() -> void:
	priority = default_priority
