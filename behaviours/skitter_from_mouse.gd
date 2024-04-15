extends Node2D
class_name SkitterFromMouse


signal move(movement: Vector2)
signal scared
signal calmed

@export var state_holder: StateHolder;
@export_range(1, 500, 1) var speed: float = 300.0
@export_range(0.1, 5, 0.1) var scare_secs: float = 0.2
@export var directions: Array[Vector2] = []

@onready var calm_timer: Timer = $"CalmTimer"
@onready var scare_area: HoverDetector = $"ScareArea"

var direction := Vector2.ZERO

const SCARED_PRIORITY = 50


func recheck():
	calm_timer.stop()
	if scare_area.mouse_inside:
		scare()
	else:
		calm()

func calm():
	if state_holder.state == 'scared':
		state_holder.reset_state()
		calmed.emit()

func scare():
	if not state_holder.propose_state('scared', SCARED_PRIORITY, recheck):
		return
	# Pick a direction
	var idx := Random.rng.randi_range(0, len(directions) - 1)
	direction = directions[idx]
	# Start the timeout for calming down
	calm_timer.start(scare_secs)
	scared.emit()


func _ready():
	if state_holder == null:
		state_holder = StateHolder.get_default(self)
	if not directions: 
		Log.w(self, "No directions defined, object won't skitter.")

func _physics_process(delta: float) -> void:
	if state_holder.state == 'scared':
		if len(directions) > 0:
			var movement: Vector2 = direction * delta * speed
			move.emit(movement)

func _on_calm_timer_timeout() -> void:
	recheck()

func _on_hover_detector_mouse_entered() -> void:
	scare()

func _on_move(movement: Vector2) -> void:
	Log.p(self, "Moving by: %s" % movement)

func _on_scared() -> void:
	Log.p(self, "Scared!")

func _on_calmed() -> void:
	Log.p(self, "Calmed down.")
