extends Move
class_name MoveTowards


## A [Move] that moves towards the [field position] of a [field target].


signal changed_target(new: Node2D)


@export var speed: float = 100.0

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

func log_target() -> void:
	Log.p(self, "Target: %s" % target)


func _physics_process(delta: float) -> void:
	if enabled:
		if target:
			var gap = target.global_position - global_position
			var norm = gap.normalized()
			move.emit(norm * delta * speed)
		else:
			move.emit(Vector2.ZERO)
