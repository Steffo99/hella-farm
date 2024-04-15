@icon("res://behaviours/eater.svg")
extends Area2D
class_name Eater

## Emits [signal eaten] whenever an [Edible] body with an acceptable [field Edible.diet] enters the given [CollisionShape2D].


signal eaten(edible: Edible)


@export var acceptable_diets: Array[StringName] = []



func _on_body_entered(body: Node2D) -> void:
	var edibles: Array = body.find_children("Edible", "Edible", false, false)
	for edible in edibles:
		if edible.diet in acceptable_diets:
			eaten.emit(edible)
			edible.eat()


func _on_eaten(edible: Edible) -> void:
	Log.p(self, "Eaten: %s" % edible)
