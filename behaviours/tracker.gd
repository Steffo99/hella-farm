@icon("res://behaviours/tracker.svg")
extends Area2D
class_name Tracker

## [Area2D]s tracking a certain subset of [Node2D]s.


signal tracked(body: Node2D)
signal untracked(body: Node2D)
signal empty

var tracking: Array = []


## Start [field tracking] a [Node2D]. 
##
## Returns whether the body was added to the [field tracking] array.
func track(body: Node2D) -> bool:
	var act: bool = not body in tracking
	if act:
		tracking.push_back(body)
		tracked.emit(body)
		# Handle TrackerTracker
		for tracker_tracker in body.find_children("*", "TrackerTracker", true, false):
			tracker_tracker.track_if_detected(self)
	return act

## Stop [field tracking] a [Node2D].
##
## Returns whether the body was removed from the [field tracking] array.
func untrack(body: Node2D) -> bool:
	var act: bool = body in tracking
	if act:
		tracking.erase(body)
		untracked.emit(body)
		if tracking.is_empty():
			empty.emit()
		# Handle TrackerTracker
		for tracker_tracker in body.find_children("*", "TrackerTracker", true, false):
			tracker_tracker.untrack(self)
	return act

func log_tracked(body: Node2D) -> void:
	Log.p(self, "Tracking a new target: %s" % body)

func log_untracked(body: Node2D) -> void:
	Log.p(self, "Not tracking anymore target: %s" % body)
