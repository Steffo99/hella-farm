extends Tracker
class_name TrackerTracker

## Tracks [Tracker]s tracking the parent.


## Start [field tracking] a [Node2D] if it overlaps this [Area2D]. 
##
## Returns whether the body was added to the [field tracking] array.
func track_if_detected(body: Node2D) -> bool:
	if overlaps_body(body):
		return track(body)
	return false

## Start [field tracking] a [Node2D] if it has a [Tracker] tracking this node or one of its ancestors.
##
## Returns whether the body was added to the [field tracking] array.
func track_if_tracked(body: Node2D) -> bool:
	var act: bool = false
	for tracker in body.find_children("*", "Tracker", true, false):
		for ancestor in Traversal.get_ancestors(self):  # Make more efficient, perhaps?
			if ancestor in tracker.tracking:
				act = track(body) or act
	return act
