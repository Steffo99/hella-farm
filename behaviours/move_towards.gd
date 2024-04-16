extends Move
class_name MoveTowards


## A [Move] that moves towards the [field position] of a [field target].


@export var target: Node2D = null


func set_target(value: Node2D) -> void:
	target = value

func clear_target() -> void:
	target = null


func _ready() -> void:
	if target == null:
		Log.w(self, "No target is set, no signals will be emitted.")

func _physics_process(_delta: float) -> void:
	if target:
		var gap = target.global_position - global_position
		var norm = gap.normalized()
		move.emit(norm)
	else:
		move.emit(Vector2.ZERO)
