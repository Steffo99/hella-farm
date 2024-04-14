extends Node2D
class_name HuntTarget


signal target_selected(target: Node2D)
signal target_abandoned(target: Node2D)


@export var tag: StringName:
	get:
		return tag
	set(value):
		tag = value
		hunter.tag = value

@export var give_up_secs: float = 5.0

@onready var give_up_timer: Timer = $"GiveUpTimer"
@onready var hunter: Hunter = $"Hunter"

var target: Node2D = null


func pick_new_target():
	var idx = Random.rng.randi_range(0, len(hunter.possible_targets) - 1)
	target = hunter.possible_targets[idx]
	target_selected.emit(target)
	give_up_timer.start(give_up_secs)

func _ready():
	hunter.tag = tag

func _on_hunter_tracked(_body: Node2D):
	if target == null:
		pick_new_target()

func _on_hunter_untracked(body: Node2D):
	if body == target:
		target = null
		pick_new_target()

func _on_give_up_timer_timeout() -> void:
	target = null
	pick_new_target()

func _on_target_selected(body: Node2D) -> void:
	Log.p(self, "Target selected: %s" % body)

func _on_target_abandoned(body: Node2D) -> void:
	Log.p(self, "Target abandoned: %s" % body)
