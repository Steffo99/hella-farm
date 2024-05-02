extends Entity
class_name Chupacabra


@export var skitter_directions: Array[Vector2] = []


@onready var movement_wander: MoveStraight = %"MovementWander"
@onready var movement_wander_tp: TargetPicker = movement_wander.get_node("TrackerMeat/TargetPicker")


func _on_dragged(_cursor: Cursor) -> void:
	set_flying()
	animator.play(&"drag_start")

func _on_fallen() -> void:
	set_grounded()
	animator.play(&"RESET")

func _on_trapped() -> void:
	set_trapped()

func _on_freed() -> void:
	set_grounded()

func _on_wander_enabled() -> void:
	if movement_wander_tp.target:
		movement_wander.steer_direction_towards(movement_wander_tp.target)
	else:
		movement_wander.randomize_direction()

func _on_gold_spawner_spawned(entity:Node2D) -> void:
	entity.get_node("MoveStraight").speed = 25
	entity.get_node("MoveStraight").randomize_direction()
	entity.get_node("MoveStraight/Priority").priority_alternative()
