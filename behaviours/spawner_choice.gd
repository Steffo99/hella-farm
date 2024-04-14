extends Node
class_name SpawnerChoice


@export var spawners: Array[Spawner] = []
@export var weights: Array[int] = []


func compute_total_weight() -> int:
	var total = 0
	for weight in weights:
		if weight < 0:
			Log.e(self, "Weight with negative value detected.")
		total += weight
	return total

func select_spawner() -> Spawner:
	var total = compute_total_weight()
	var sampled = Random.rng.randi_range(0, total - 1)
	var idx = -1
	while sampled >= 0:
		idx += 1
		sampled -= weights[idx]
	return spawners[idx]

func spawn():
	select_spawner().spawn()


func _ready():
	if len(spawners) != len(weights):
		Log.e(self, "Spawners and weights are different lengths.")
	if compute_total_weight() <= 0:
		Log.e(self, "Weight total is less or equal to 0.")
