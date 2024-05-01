@icon("res://behaviours/eater.svg")
extends Area2D
class_name Eater

## Emits [signal eaten] whenever an [Edible] body with an acceptable [field Edible.diet] enters the given [CollisionShape2D].


signal eaten(edible: Edible)

## Emitted when the [field goal] number of entities has been eaten. 
signal goal_reached


@export var acceptable_diets: Array[StringName] = []

@export var target = -1

## Count of how many times something was eaten.
var count: int = 0


func log_eaten(edible: Edible) -> void:
	Log.p(self, "Eaten: %s" % edible)

func plus_one():
	count += 1
	if count == target:
		goal_reached.emit()



func _on_body_entered(body: Node2D) -> void:
	var edibles: Array = body.find_children("Edible", "Edible", false, false)
	for edible in edibles:
		if edible.diet in acceptable_diets:
			eaten.emit(edible)
			edible.eat()
			plus_one()
