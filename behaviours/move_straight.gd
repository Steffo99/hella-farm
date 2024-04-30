extends Move
class_name MoveStraight

## A [Move] that moves in a fixed direction.


signal changed_direction(new: Vector2)


@export var speed: float = 100.0

@export var direction: Vector2:
	get: 
		return direction
	set(value):
		direction = value
		changed_direction.emit(direction)


func set_direction(value: Vector2) -> void:
	direction = value

func steer_direction_towards(node: Node2D) -> void:
	if node != null:
		direction = global_position.direction_to(node.global_position)

func clear_direction() -> void:
	direction = Vector2.ZERO

func randomize_direction() -> void:
	direction = Vector2.from_angle(Random.rng.randf_range(0, 2*PI))

func randomize_direction_if_zero() -> void:
	if direction == Vector2.ZERO:
		randomize_direction()

func log_state() -> void:
	Log.p(self, "Direction: %s | Speed: %s" % [direction, speed])

 
func _physics_process(delta: float) -> void:
	if enabled:
		move.emit(direction * delta * speed)
