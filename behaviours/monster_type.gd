@icon("res://behaviours/monster_type.svg")
extends Node
class_name MonsterType

## Emits [signal eaten] when eaten by an [Eater] whose acceptable diets contain this node's [field diet].
##
## To add multiple possible [Edible] diets to an entity, add multiple [Edible] nodes to it.

signal sacrificed


@export var type: Enums.MonsterType = Enums.MonsterType.Sheep


func sarcifice():
	sacrificed.emit()
