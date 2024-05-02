extends BetterCharacterBody2D
class_name Cthulhu


@onready var sprite: SpriteLeftRight = %"Sprite"
@onready var animator: AnimationPlayer = %"Animator"
@onready var tophatter: Eater = %"TopHatter"
@onready var monocler: Eater = %"Monocler"

func _ready():
	# Setup index and layers
	_on_fallen()

func _on_move(movement: Vector2):
	better_move_and_collide(movement)
	sprite.handle_move(movement)

func _on_dragged(_cursor: Cursor) -> void:
	collision_layer = 16
	collision_mask = 16
	tophatter.collision_mask = 16
	monocler.collision_mask = 16
	z_index = Enums.ZIndex.EntityAir
	y_sort_enabled = false
	animator.play(&"drag_start")

func _on_fallen() -> void:
	collision_layer = 8
	collision_mask = 8
	tophatter.collision_mask = 8
	monocler.collision_mask = 8
	z_index =  Enums.ZIndex.EntityGround
	y_sort_enabled = true
	animator.play(&"RESET")

func _on_eater_eaten(edible: Edible) -> void:
	edible.get_parent().queue_free()
