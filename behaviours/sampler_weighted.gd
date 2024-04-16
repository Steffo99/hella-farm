extends Sampler
class_name SamplerWeighted


## Sample a random reference from the array, considering the given weights.


@export var possibilities: Array = []
@export var weights: Array[int] = []


func sample() -> Object:
	var total = compute_total_weight()
	if total == 0:
		return null
	var sampled = Random.rng.randi_range(0, total - 1)
	var idx = -1
	while sampled >= 0:
		idx += 1
		sampled -= weights[idx]
	return possibilities[idx]

func compute_total_weight() -> int:
	var total = 0
	for weight in weights:
		if weight < 0:
			Log.e(self, "Weight with negative value detected.")
			return 0
		total += weight
	return total
