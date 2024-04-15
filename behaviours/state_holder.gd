extends Node2D
class_name StateHolder

signal on_changed(state: StringName, priority: int)

const DEFAULT_STATE: StringName = "idle"
const DEFAULT_PRIORITY: int = 0

var _state: StringName = DEFAULT_STATE
var _priority: int
var _exit_callback: Callable = no_callback

var state: StringName :
	get:
		return _state

var priority: int :
	get:
		return _priority

func set_state(new_state: StringName, new_priority: int, exit_callback: Callable = no_callback) -> void:
	# Priority should be checked outside otherwise we never decrease it
	
	# Prevent recursion problems
	var prev_callback = _exit_callback
	_state = new_state
	_priority = new_priority
	_exit_callback = exit_callback
	prev_callback.call()
	on_changed.emit(new_state, new_priority)

func propose_state(new_state: StringName, new_priority: int, exit_callback: Callable = no_callback) -> bool:
	if new_priority > _priority:
		set_state(new_state, new_priority, exit_callback)
		return true
	return false

func reset_state() -> void:
	set_state(DEFAULT_STATE, DEFAULT_PRIORITY)

func remove_state(previous_state: StringName) -> void:
	if _state == previous_state:
		reset_state()


func no_callback():
	pass


static func get_default(current: Node2D) -> StateHolder:
	# Try some default paths
	for path in [^"../StateHolder", ^"../State"]:
		var node = current.get_node_or_null(path)
		if node != null:
			return node
	# Try to get a StateHolder from the parent's children
	for child in current.get_parent().get_children():
		if child is StateHolder:
			return child
	
	# Create one (hard way)
	Log.w(current, "No StateHolder found, please create one or connect one")
	var holder = StateHolder.new()
	holder.set_name("StateHolder")
	current.get_parent().add_child(holder)
	return holder
	
	
