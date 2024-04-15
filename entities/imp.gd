extends CharacterBody2D
class_name Imp

@export var skull_chance: float = 0.2

@onready var skull_spawner: Spawner = $"SkullSpawner"
@onready var draggable: Draggable = $"Draggable"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_eat_target_eaten(_target: Edible):
	if Random.rng.randf() < skull_chance:
		skull_spawner.spawn()


func _on_draggable_move(movement:Vector2):
	if draggable.being_dragged:
		print("move", movement)
		move_and_collide(movement)

func _on_move(movement:Vector2):
	if not draggable.being_dragged:
		print("move", movement)
		move_and_collide(movement)