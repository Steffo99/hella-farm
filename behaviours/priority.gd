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

var priority: int = 0


## Set [field priority] to [field default_priority].
func default() -> void:
	set_priority(default_priority)

## Set [field priority] to [field alternative_priority]
func alternative() -> void:
	set_priority(alternative_priority)

## Toggle [field priority] between [field default_priority] and [field alternative_priority].
func toggle_priority() -> void:
	if priority == default_priority:
		set_priority(alternative_priority)
	else:
		set_priority(default_priority)

## Set the [field priority] to a specific value.
func set_priority(value: int):
	var old = priority
	priority = value
	priority_changed.emit(priority, old)

## Set the [field priority] to a specific value if the [param variant] is truthy, otherwise set it to a different value.
func set_priority_if_truthy(variant: Variant, truthy: int, falsy: int = 0):
	if variant:
		set_priority(truthy)
	else:
		set_priority(falsy)

## Get the node to which the [field priority] of this one applies to.
func get_ref() -> Node:
	return get_parent()


func _on_priority_changed(new: int, _old: int) -> void:
	Log.p(self, "Priority changed to: %s" % new)
	priority_changed_no_args.emit()

func _ready() -> void:
	priority = default_priority
