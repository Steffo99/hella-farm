extends MoveStraight
class_name MoveTilt


## A [Move] which moves in a direction, rotating by a bit each frame.


## Speed at which the direction changes per second, in degrees per second.
@export var rotation_speed: float = 0.0

## The minimum [field rotation_speed] that will be set.
@export var min_rotation_speed: float = 0.0

## The maximum [field rotation_speed] that will be set.
@export var max_rotation_speed: float = 0.0


func set_rotation_speed(value: float) -> void:
	rotation_speed = value

func set_rotation_speed_to_min() -> void:
	rotation_speed = min_rotation_speed

func set_rotation_speed_to_max() -> void:
	rotation_speed = max_rotation_speed

func randomize_rotation_speed() -> void:
	rotation_speed = Random.rng.randf_range(min_rotation_speed, max_rotation_speed)


func _physics_process(delta: float) -> void:
	if enabled:
		move.emit(direction * delta * speed)
		direction = direction.rotated(deg_to_rad(delta * rotation_speed))
