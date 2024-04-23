extends Sampler
class_name SamplerPriority


## If true, the [SamplerPriority] will attempt to automatically setup the recommended signals for all the [field possibilities] on NOTIFICATION_READY.
@export var autosetup_signals_on_ready: bool = true


## Update [field possibilities] with the most likely subset of nodes.
func autodetect_possibilities() -> void:
	possibilities = find_children("*", "Priority", true, false)

## Setup the recommended signals for each node in [field possibilities].
func autosetup_signals() -> void:
	for possibility in possibilities:
		possibility.priority_changed.connect(_autosetup_on_possibility_priority_changed.bind(possibility))

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

	return highest_possibility

func get_all_refs() -> Array[Node]:
	var refs: Array[Node] = []
	for possibility in possibilities:
		refs.append(possibility.get_ref())
	return refs

func get_ref(node: Node) -> Node:
	return node.get_ref()


func _ready():
	if autosetup_signals_on_ready:
		autosetup_signals()

func _autosetup_on_possibility_priority_changed(node: Priority, new: int, old: int):
	if node == selected:
		if new < old:
			sample_and_enable()
	else:
		# A nice optimization!
		if selected == null or new > selected.priority:
			set_enabled(node)
