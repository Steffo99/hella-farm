extends Node2D
class_name Hunter


signal tracked(body: Node2D)
signal untracked(body: Node2D)


@export var tag: StringName

var possible_targets: Array = []


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.find_children("Edible", "Edible", false, false):
		Log.p(self, "Tracking a new target: %s" % body)
		possible_targets.push_back(body)
		tracked.emit(body)

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body in possible_targets:
		Log.p(self, "Not tracking anymore target: %s" % body)
		possible_targets.erase(body)
		untracked.emit(body)
