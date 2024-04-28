@icon("res://behaviours/sacrificable.svg")
extends Node
class_name Sacrificable


## Emits [signal eaten] when eaten by an [Eater] whose acceptable diets contain this node's [field diet].
##
## To add multiple possible [Edible] diets to an entity, add multiple [Edible] nodes to it.

signal sacrificed


@export var type: SacrificeKind = SacrificeKind.Sheep


func sarcifice():
	sacrificed.emit()


enum SacrificeKind {
    None = 0, # I hate this but in GDScript enums can't be nulls and there aren't any sum types like in rust so this is all we can do
    Sheep,
    Imp,
    Chupacabra,
    Watcher,
    Cthulhu,
}
