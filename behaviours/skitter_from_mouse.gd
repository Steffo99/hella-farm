extends Node2D
class_name SkitterFromMouse


signal move(movement: Vector2)
signal scared
signal calmed


@export_range(1, 5, 1) var speed := 2.0
@export_range(1, 5, 1) var scare_secs := 1.0
@export var directions: Array[Vector2] = []

@onready var calm_timer: Timer = $"CalmTimer"
@onready var hover_detector: HoverDetector = $"HoverDetector"


enum State { CALM, SCARED }

var state: State = State.CALM


func calm():
	state = State.CALM
	calmed.emit()

func scare():
	state = State.SCARED
	calm_timer.start(scare_secs)
	scared.emit()


func _ready():
	if not directions: 
		Log.w(self, "No directions defined, object won't skitter.")

func _physics_process(delta: float) -> void:
	match state:
		State.SCARED:
			if len(directions) > 0:
				var idx := Random.rng.randi_range(0, len(directions))
				var direction: Vector2 = directions[idx]
				var movement: Vector2 = direction * delta * speed
				move.emit(movement)

func _on_calm_timer_timeout() -> void:
	if hover_detector.mouse_inside:
		scare()
	else:
		calm()

func _on_hover_detector_mouse_entered() -> void:
	scare()

func _on_move(movement: Vector2) -> void:
	Log.p(self, "Moving by: %s" % movement)

func _on_scared() -> void:
	Log.p(self, "Scared!")

func _on_calmed() -> void:
	Log.p(self, "Calmed down.")