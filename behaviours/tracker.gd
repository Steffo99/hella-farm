@icon("res://behaviours/tracker.svg")
extends Area2D
class_name Tracker

## Abstract base class for [Area2D]s tracking a certain subset of [Node2D]s.


signal tracked(body: Node2D)
signal untracked(body: Node2D)

var tracking: Array = []


func track(body: Node2D) -> bool:
	var act: bool = not body in tracking
	if act:
		tracking.push_back(body)
		tracked.emit(body)
		# Handle TrackerTracker
		for tracker_tracker in body.find_children("*", "TrackerTracker", false, false):
			tracker_tracker.track(self)
	return act

func untrack(body: Node2D) -> bool:
	var act: bool = body in tracking
	if act:
		tracking.erase(body)
		untracked.emit(body)
		# Handle TrackerTracker
		for tracker_tracker in body.find_children("*", "TrackerTracker", false, false):
			tracker_tracker.untrack(self)
	return act

func log_tracked(body: Node2D) -> void:
	Log.p(self, "Tracking a new target: %s" % body)

func log_untracked(body: Node2D) -> void:
	Log.p(self, "Not tracking anymore target: %s" % body)
