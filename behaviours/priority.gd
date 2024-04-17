@icon("res://behaviours/priority.svg")
extends Node
class_name Priority


## Keeps track of the object's priority


signal priority_changed(new: int, old: int)
signal priority_changed_no_args


@export var priority: int = 0


func set_priority(value: int):
	var old = priority
	priority = value
	priority_changed.emit(priority, old)

func set_priority_if_truthy(variant: Variant, truthy: int, falsy: int = 0):
	if variant:
		set_priority(truthy)
	else:
		set_priority(falsy)

func get_ref() -> Node:
	return get_parent()


func _on_priority_changed(new: int, _old: int) -> void:
	Log.p(self, "Priority changed to: %s" % new)
	priority_changed_no_args.emit()
