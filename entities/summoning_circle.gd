extends Node2D
class_name SummoningCircle

@onready var spawner: Spawner = %"Spawner"

## The scene to spawn.
@export var scene_imp: PackedScene


## The [SacrificeStone]s part of this summoning circle.
var stones: Array[SacrificeStone] = []


## Refresh the value of [field stones].
func refresh_stones() -> void:
	stones.assign(
		find_children("*", "SacrificeStone", false, false)
	)

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
