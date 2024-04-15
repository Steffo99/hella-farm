@icon("res://behaviours/edible_tracker.svg")
extends Area2D
class_name EdibleTracker

## Keeps track of what [Edible]s are inside the area.


signal tracked(body: Node2D)
signal untracked(body: Node2D)


@export var acceptable_diets: Array[StringName] = []

var tracking: Array = []


func _on_body_entered(body: Node2D) -> void:
	var edibles: Array = body.find_children("Edible", "Edible", false, false)
	for edible in edibles:
		if edible.tag in acceptable_diets:
			tracking.push_back(body)
			tracked.emit(body)

func _on_body_exited(body: Node2D) -> void:
	if body in tracking:
		tracking.erase(body)
		untracked.emit(body)


func _on_tracked(body: Node2D) -> void:
	Log.p(self, "Tracking a new target: %s" % body)

func _on_untracked(body:Node2D) -> void:
	Log.p(self, "Not tracking anymore target: %s" % body)
