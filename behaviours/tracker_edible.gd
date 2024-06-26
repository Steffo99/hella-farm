extends Tracker
class_name EdibleTracker

## Keeps track of what [Edible]s are inside the area.


@export var acceptable_diets: Array[StringName] = []


func check_diet_then_track(body: Node2D) -> void:
	var edibles: Array = body.find_children("*", "Edible", false, false)
	for edible in edibles:
		if edible.diet in acceptable_diets:
			track(body)
			break
