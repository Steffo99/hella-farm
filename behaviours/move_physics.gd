extends Move
class_name MovePhysics


signal dragged(cursor: Cursor)
signal dropped
signal fallen


@export var acceleration = 650.0
@export var linear_damp = 18.0

var cursor: Cursor = null

var velocity := Vector2.ZERO

@onready var ticks_per_second = ProjectSettings.get_setting("physics/common/physics_ticks_per_second")


func drag(value: Cursor) -> void:
	cursor = value
	dragged.emit(value)

func drop() -> void:
	cursor = null
	dropped.emit()

func fall() -> void:
	velocity = Vector2.ZERO
	fallen.emit()


func _physics_process(delta: float) -> void:
	if enabled:
		if cursor:
			var gap = cursor.global_position - global_position
			velocity += gap * delta * acceleration
		velocity *= 1.0 - linear_damp / ticks_per_second
		move.emit(velocity * delta)
