extends StaticBody2D
class_name Barn


signal coin_inserted


@onready var sheep_spawner: Spawner = %"SheepSpawner"
@onready var blocked_tracker: Tracker = %"BlockedTracker"
@onready var animator: AnimationPlayer = %"Animator"
@onready var game := MainGame.get_via_group(self)


func _on_roof_input(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	var gold_counter = game.inventory.get_counter(&"Gold")
	if gold_counter.value < 5:
		return
	if blocked_tracker.tracking:
		return
	if not event is InputEventMouseButton:
		return
	if not event.pressed:
		return
	gold_counter.decrease(5)
	animator.play(&"coin")

func _on_animation_finished(anim_name:StringName) -> void:
	if anim_name == &"coin":
		coin_inserted.emit()

func _on_sheep_spawned(entity: Node2D) -> void:
	Log.p(self, "%s" % entity)
	entity.get_node("MovementBarn/BarnPriority").priority_alternative()
