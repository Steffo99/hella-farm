extends MoveTowards
class_name MoveTowardsGravity


# [field speed] is actually used as acceleration. Oh well.

var velocity := Vector2.ZERO


func _physics_process(delta: float) -> void:
	if enabled:
		if target:
			var gap = target.global_position - global_position
			var norm = gap.normalized()
			velocity += norm * delta * speed
			Log.p(self, "Velocity: %s" % velocity)
		move.emit(velocity * delta)
