extends CharacterBody2D
class_name Imp

@export var skull_chance: float = 0.2

@onready var skull_spawner: Spawner = $"SkullSpawner"
@onready var sprite: SpriteLeftRight = $"Sprite"
@onready var draggable: Draggable = $"Draggable"


func _on_eat_target_eaten(target: Edible):
	target.queue_free()
	if Random.rng.randf() < skull_chance:
		skull_spawner.spawn()


func _on_draggable_move(movement:Vector2):
	if draggable.being_dragged:
		move_and_collide(movement)
		sprite.handle_move(movement)

func _on_move(movement:Vector2):
	if not draggable.being_dragged:
		move_and_collide(movement)
		sprite.handle_move(movement)
