@icon("res://behaviours/tracker_edible.svg")
extends Tracker
class_name EdibleTracker

## Keeps track of what [Edible]s are inside the area.


@export var acceptable_diets: Array[StringName] = []


func check_diet_then_track(body: Node2D) -> void:
	var edibles: Array = body.find_children("Edible", "Edible", false, false)
	for edible in edibles:
		if edible.tag in acceptable_diets:
			track(body)
			break
