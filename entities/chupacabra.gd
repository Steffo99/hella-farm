extends BetterCharacterBody2D
class_name Chupacabra


@export var skitter_directions: Array[Vector2] = []


@onready var sprite: SpriteLeftRight = %"Sprite"
@onready var movement_wander: MoveStraight = %"MovementWander"
@onready var movement_wander_tp: TargetPicker = movement_wander.get_node("TrackerMeat/TargetPicker")
@onready var animator: AnimationPlayer = %"Animator"
@onready var eater: Eater = %"Eater"
@onready var tophatter: Eater = %"TopHatter"
@onready var monocler: Eater = %"Monocler"


func _on_move(movement: Vector2) -> void:
	move_and_collide(movement)
	sprite.handle_move(movement)

func _on_eater_eaten(edible:Edible) -> void:
	edible.get_parent().queue_free()

func _on_dragged(_cursor: Cursor) -> void:
	collision_layer = 16
	collision_mask = 16
	tophatter.collision_mask = 16
	monocler.collision_mask = 16
	z_index = Enums.ZIndex.EntityAir
	y_sort_enabled = false
	eater.collision_mask = 16
	animator.play(&"drag_start")

func _on_fallen() -> void:
	collision_layer = 8
	collision_mask = 8
	tophatter.collision_mask = 8
	monocler.collision_mask = 8
	z_index = Enums.ZIndex.EntityGround
	y_sort_enabled = true
	eater.collision_mask = 8
	animator.play(&"RESET")

func _on_trapped() -> void:
	z_index = Enums.ZIndex.EntitySacrifice
	y_sort_enabled = false

func _on_freed() -> void:
	z_index = Enums.ZIndex.EntityGround
	y_sort_enabled = true

func _on_wander_enabled() -> void:
	if movement_wander_tp.target:
		movement_wander.steer_direction_towards(movement_wander_tp.target)
	else:
		movement_wander.randomize_direction()
