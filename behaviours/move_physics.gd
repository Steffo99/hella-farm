extends Move
class_name MovePhysics


signal dragged(cursor: Cursor)
signal dropped
signal fallen


@export var acceleration = 1250.0
@export var drag_damp = 0.4
@export var drop_damp = 0.05
@export var drop_epsilon = 16.0

var cursor: Cursor = null
var falling: bool = false

var velocity := Vector2.ZERO


func drag(value: Cursor) -> void:
	cursor = value
	dragged.emit(value)

func drop() -> void:
	cursor = null
	falling = true
	dropped.emit()

func fall() -> void:
	velocity = Vector2.ZERO
	falling = false
	fallen.emit()


func _physics_process(delta: float) -> void:
	if enabled:
		if cursor:
			var gap = cursor.global_position - global_position
			velocity += gap * delta * acceleration
			velocity *= 1.0 - drag_damp
		else:
			velocity *= 1.0 - drop_damp
		if falling and velocity.length() < drop_epsilon:
			fall()
		move.emit(velocity * delta)
