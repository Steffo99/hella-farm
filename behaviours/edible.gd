extends Node
class_name Edible


signal eaten


func eat():
	eaten.emit()
	get_parent().queue_free()


@export var tag: StringName
