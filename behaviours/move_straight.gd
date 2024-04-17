extends Move
class_name MoveStraight

## A [Move] that moves in a fixed direction.


signal changed_direction(new: Vector2)


@export var direction: Vector2:
	get: 
		return direction
	set(value):
		direction = value
		changed_direction.emit(direction)


func randomize_direction() -> void:
	direction = Vector2.from_angle(Random.rng.randf_range(0, 2*PI))


func _physics_process(_delta: float) -> void:
	if enabled:
		move.emit(direction)
