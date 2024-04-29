extends BetterCharacterBody2D
class_name Chupacabra


@export var skitter_directions: Array[Vector2] = []


@onready var sprite: SpriteLeftRight = %"Sprite"
@onready var movement_skitter: MoveStraight = %"MovementSkitter"
@onready var animator: AnimationPlayer = %"Animator"
@onready var eater: Eater = %"Eater"


func _on_cursor_detected(_cursor: Cursor) -> void:
	var direction = Random.sample(skitter_directions)
	movement_skitter.set_direction(direction)

func _on_move(movement: Vector2) -> void:
	move_and_collide(movement)
	sprite.handle_move(movement)

func _on_eater_eaten(edible:Edible) -> void:
	edible.get_parent().queue_free()

func _on_dragged(_cursor: Cursor) -> void:
	collision_layer = 16
	collision_mask = 18
	z_index = 1
	eater.collision_mask = 16
	animator.play(&"drag_start")

func _on_fallen() -> void:
	collision_layer = 8
	collision_mask = 14
	z_index = 0
	eater.collision_mask = 8
	animator.play(&"RESET")

func _on_trapped() -> void:
	z_index = Enums.ZIndex.EntitySacrifice

func _on_freed() -> void:
	z_index = Enums.ZIndex.EntityGround
