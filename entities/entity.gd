extends BetterCharacterBody2D
class_name Entity


## The [SpriteLeftRight] of this entity, or null if it doesn't have one.
@onready var sprite: SpriteLeftRight = get_node_or_null("%Sprite")

## The main [Eater] of this entity, or null if it doesn't have one.
@onready var eater: Eater = get_node_or_null("%Eater")

## The main [AnimationPlayer] of this entity, or null if it doesn't have one.
@onready var animator: AnimationPlayer = get_node_or_null("%Animator")

## The [Eater] controlling the appearence of the [TopHat] on this entity, or null if this isn't supported. 
@onready var tophatter: Eater = get_node_or_null("%TopHatter")

## The [Eater] controlling the appearence of the [Monocle] on this entity, or null if this isn't supported.
@onready var monocler: Eater = get_node_or_null("%Monocler")


enum State {
	GROUNDED = 0,
	FLYING = 1,
	TRAPPED = 2,
}

## The [State] this entity is in.
var state := State.GROUNDED


## Set the entity to be considered walking on the ground. 
func set_grounded():
	state = State.GROUNDED
	collision_layer = Enums.PhysLayers.EntityGround
	collision_mask = Enums.PhysLayers.EntityGround
	if tophatter:
		tophatter.collision_mask = Enums.PhysLayers.EntityGround
	if monocler:
		monocler.collision_mask = Enums.PhysLayers.EntityGround
	if eater:
		eater.collision_mask = Enums.PhysLayers.EntityGround
	z_index = Enums.ZIndex.EntityGround
	y_sort_enabled = true

## Set the entity to be considered hovering in the air.
func set_flying():
	state = State.FLYING
	collision_layer = Enums.PhysLayers.EntityAir
	collision_mask = Enums.PhysLayers.EntityAir
	if tophatter:
		tophatter.collision_mask = Enums.PhysLayers.EntityAir
	if monocler:
		monocler.collision_mask = Enums.PhysLayers.EntityAir
	if eater:
		eater.collision_mask = Enums.PhysLayers.EntityAir
	z_index = Enums.ZIndex.EntityAir
	y_sort_enabled = false

## Set the entity to be considered trapped in a [SacrificeStone].
func set_trapped():
	state = State.TRAPPED
	z_index = Enums.ZIndex.EntitySacrifice
	y_sort_enabled = false

## Handle a signal controlling movement.
func handle_movement(movement: Vector2) -> void:
	better_move_and_collide(movement)
	if sprite:
		sprite.handle_move(movement)

## Initialize the signals of the [field tophatter], if it exists.
func _init_tophatter_signals() -> void:
	if tophatter:
		var subsprite: Sprite2D = tophatter.get_node("Sprite")
		var spawner: Spawner = tophatter.get_node("Spawner")
		var sacrificable: Sacrificable = tophatter.get_node_or_null("Sacrificable")
		tophatter.eaten.connect(func(edible: Edible): edible.queue_free())
		tophatter.goal_reached.connect(tophatter.clear_diets)
		tophatter.goal_reached.connect(subsprite.show)
		tophatter.goal_reached.connect(spawner.enable)
		spawner.tree_exiting.connect(spawner.spawn)
		if sacrificable:
			sacrificable.sacrificed.connect(queue_free)
			tophatter.goal_reached.connect(func(): sacrificable.set_kind(&"TopHat"))

## Initialize the signals of the [field monocler], if it exists.
func _init_monocler_signals() -> void:
	if monocler:
		var subsprite: Sprite2D = monocler.get_node("Sprite")
		var spawner: Spawner = monocler.get_node("Spawner")
		var sacrificable: Sacrificable = monocler.get_node_or_null("Sacrificable")
		monocler.eaten.connect(func(edible: Edible): edible.queue_free())
		monocler.goal_reached.connect(monocler.clear_diets)
		monocler.goal_reached.connect(subsprite.show)
		monocler.goal_reached.connect(spawner.enable)
		spawner.tree_exiting.connect(spawner.spawn)
		if sacrificable:
			monocler.goal_reached.connect(func(): sacrificable.set_kind(&"Monocle"))
			sacrificable.sacrificed.connect(queue_free)


## Backwards compatible name for [method handle_movement].
func _on_move(movement: Vector2) -> void:
	handle_movement(movement)

func _ready() -> void:
	_init_tophatter_signals()
	_init_monocler_signals()
