extends Node2D
class_name RandomWalk


signal move(movement: Vector2)


@export var speed: float = 100.0

@export var wait_time_mean: float = 4
@export var wait_time_dev: float = 1.5
@export var wander_time_mean: float = 5.0
@export var wander_time_dev: float = 1.0

@export var state_holder: StateHolder

@onready var rand_walk_timer: Timer = Timer.new()

var walk_dir: Vector2 = Vector2.ZERO


func _ready():
	if state_holder == null:
		state_holder = StateHolder.get_default(self)

	add_child(rand_walk_timer)
	rand_walk_timer.one_shot = true;
	rand_walk_timer.connect("timeout", _on_timer_timeout)

	state_holder.on_changed.connect(init_timer.unbind(2))
	init_timer()

func _physics_process(delta: float) -> void:
	if state_holder.state != 'wander':
		return
	var movement: Vector2 = speed * walk_dir * delta
	move.emit(movement)

func init_timer():
	match state_holder.state:
		'idle':
			var rand_time = max(0, Random.rng.randfn(wait_time_mean, wait_time_dev))
			rand_walk_timer.start(rand_time)
		'wander':
			var rand_time = max(0, Random.rng.randfn(wander_time_mean, wander_time_dev))
			rand_walk_timer.start(rand_time)
		_:
			rand_walk_timer.stop()

func _on_timer_timeout():
	match state_holder.state:
		'idle':
			state_holder.set_state('wander', 10)
			walk_dir = Vector2.from_angle(Random.rng.randf_range(0, 2*PI))
		'wander':
			state_holder.reset_state()