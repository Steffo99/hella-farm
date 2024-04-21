extends Node2D
class_name Gold


@onready var game: MainGame = MainGame.get_via_group(self)
@onready var move_towards: MoveTowards = %"MoveTowards"
@onready var collect_sound_spawner: Spawner = %"CollectSoundSpawner"
@onready var collectible: Collectible = %"Collectible"


func magnetize(cursor: Cursor) -> void:
	move_towards.target = cursor

func demagnetize() -> void:
	move_towards.target = null

func collect() -> void:
	collectible.apply()
	collect_sound_spawner.spawn()
	queue_free()


func _on_move(movement: Vector2) -> void:
	position += movement
