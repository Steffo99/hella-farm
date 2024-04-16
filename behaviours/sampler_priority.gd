extends Sampler
class_name SamplerPriority


## Always sample the object with the highest priority in the queue.


@export var possibilities: Array[Priority] = []


## Get a reference.
func sample() -> Priority:
	if len(possibilities) == 0:
		return null

	# FIXME: Change this to something more efficient when needed
	var highest_possibility: Priority = null	
	for possibility in possibilities:
		if possibility.priority > highest_possibility.priority:
			highest_possibility = possibility
	
	if highest_possibility == null:
		return null
	
	return highest_possibility.get_ref()
