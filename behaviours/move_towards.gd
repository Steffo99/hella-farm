extends Move
class_name MoveTowards


## A [Move] that moves towards the [field position] of a [field target].


signal changed_target(new: Node2D)


@export var target: Node2D = null:
	get:
		return target
	set(value):
		target = value
		changed_target.emit(value)


func set_target(value: Node2D) -> void:
	target = value

func clear_target() -> void:
	target = null


func _physics_process(_delta: float) -> void:
	if enabled:
		if target:
			var gap = target.global_position - global_position
			var norm = gap.normalized()
			move.emit(norm)
		else:
			move.emit(Vector2.ZERO)

func _on_changed_target(new: Node2D) -> void:
	Log.p(self, "Changed target to: %s" % new)
