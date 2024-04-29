extends BetterCharacterBody2D
class_name Imp


@onready var sprite: SpriteLeftRight = %"Sprite"
@onready var eater: Eater = %"Eater"
@onready var animator: AnimationPlayer = %"Animator"


func _ready():
	# Setup index and layers
	_on_fallen()

func _on_move(movement: Vector2):
	better_move_and_collide(movement)
	sprite.handle_move(movement)

func _on_eater_eaten(edible: Edible) -> void:
	edible.get_parent().queue_free()

func _on_dragged(_cursor: Cursor) -> void:
	collision_layer = 16
	collision_mask = 18
	z_index = Enums.ZIndex.EntityAir
	y_sort_enabled = false
	eater.collision_mask = 16
	animator.play(&"drag_start")

func _on_fallen() -> void:
	collision_layer = 8
	collision_mask = 14
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
