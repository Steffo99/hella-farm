@icon("res://behaviours/edible.svg")
extends Node
class_name Edible

## Emits [signal eaten] when eaten by an [Eater] whose acceptable diets contain this node's [field diet].
##
## To add multiple possible [Edible] diets to an entity, add multiple [Edible] nodes to it.

signal eaten


@export var diet: StringName = &""


func eat():
	eaten.emit()
