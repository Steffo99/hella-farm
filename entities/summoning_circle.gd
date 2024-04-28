extends Node2D
class_name SacrificeCircle

@onready var spawner: Spawner = $"Spawner"

## The scene to spawn.
@export var scene_imp: PackedScene


var stones: Array[SacrificeStone]
var sacrifices: Array[Enums.MonsterType]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stones = []
	sacrifices = []
	stones.assign(find_children("*", "SacrificeStone", true, false))

	for stone in stones:
		sacrifices.append(stone.current_type)

func refresh_sacrifices() -> void:
	for i in len(stones):
		sacrifices[i] = stones[i].current_type

func try_sacrifice() -> void:
	var first_monster = sacrifices[0]
	var all_same = true
	for m in sacrifices:
		if m != first_monster:
			all_same = false
			break
	if not all_same:
		return

	if first_monster == Enums.MonsterType.Sheep:
		spawn(scene_imp)

func spawn(type: PackedScene) -> void:
	spawner.scene = type
	spawner.spawn()

	for s in stones:
		s.entity.queue_free()

func _on_sacrifice_changed(_entity: Node2D, _type: Enums.MonsterType):
	refresh_sacrifices()
	try_sacrifice()
