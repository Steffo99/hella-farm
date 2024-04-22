extends Sampler
class_name SamplerPriority


## Always sample the object with the highest priority in the queue.
var selected_priority = 0;

func _ready():
	for possibility in possibilities:
		possibility.link(self)

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
	
	selected_priority = highest_possibility.priority

	return highest_possibility

func on_priority_changed(node: Node):
	if node == selected:
		if node.priority > selected_priority:
			selected_priority = node.priority
		else:
			sample_and_enable()
	else:
		if selected == null or node.priority > selected.priority:
			set_enabled(node)

func get_all_refs() -> Array[Node]:
	var refs: Array[Node] = []
	for possibility in possibilities:
		refs.append(possibility.get_ref())
	return refs

func get_ref(node: Node) -> Node:
	return node.get_ref()