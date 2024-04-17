extends Timer
class_name TimerStddev


## A [Timer] which randomizes its [field wait_time] at each timeout.


@export_range(0, 10, 0.1, "or_greater") var mean_secs: float = 1.0
@export var deviation: float = 1.0
@export_range(0, 10, 0.1, "or_greater") var min_secs: float = 0.0
@export_range(0, 10, 0.1, "or_greater") var max_secs: float = 2.0


func randomize_wait_time() -> void:
	wait_time = clampf(
		min_secs,
		Random.rng.randfn(mean_secs, deviation),
		max_secs
	)


func _ready() -> void:
	randomize_wait_time()
