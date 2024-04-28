extends Node2D
class_name SummoningCircle


## The [SacrificeStone]s part of this summoning circle.
var stones: Array[SacrificeStone] = []


## Refresh the value of [field stones], and reconnect signals accordingly.
func refresh_stones() -> void:
	stones.map(func(stone: SacrificeStone):
		if stone == null:
			return
		if stone.sacrifice_changed.is_connected(self._on_sacrifice_changed):
			stone.sacrifice_changed.disconnect(self._on_sacrifice_changed)
	)
	stones.assign(
		find_children("*", "SacrificeStone", true, false)
	)
	stones.map(func(stone: SacrificeStone):
		stone.sacrifice_changed.connect(self._on_sacrifice_changed)
	)


func _ready() -> void:
	refresh_stones()

func _on_sacrifice_changed(_entity: Node2D) -> void:
	Log.w(self, "Sacrifice has changed, but no summoning function is implemented.")
