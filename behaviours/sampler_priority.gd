extends Sampler
class_name SamplerPriority


## Always sample the object with the highest priority in the queue.


## Get a reference.
func sample() -> Priority:
	if len(possibilities) == 0:
		return null

	# FIXME: Change this to something more efficient when needed
	var highest_possibility: Priority = null	
	for possibility in possibilities:
		if highest_possibility == null or possibility.priority > highest_possibility.priority:
			highest_possibility = possibility
	
	if highest_possibility == null:
		return null
	
	Log.p(self, "Sampled: %s" % highest_possibility)
	return highest_possibility.get_ref()

func get_refs() -> Array[Node]:
	var refs: Array[Node] = []
	for possibility in possibilities:
		refs.append(possibility.get_ref())
	return refs
