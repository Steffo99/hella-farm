extends Timer
class_name TimerStddev


## A [Timer] which randomizes its [field wait_time] at each timeout.


@export var mean_secs: float = 1.0
@export var deviation: float = 1.0
@export var min_secs: float = 0.0
@export var max_secs: float = 2.0
@export var randomize_on_ready: bool = true


func randomize_wait_time() -> void:
	wait_time = clampf(
		min_secs,
		Random.rng.randfn(mean_secs, deviation),
		max_secs
	)


func _ready() -> void:
	if randomize_on_ready:
		randomize_wait_time()
