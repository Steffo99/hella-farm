extends Sampler
class_name SamplerRandom


## Sample a random reference from the array.


func sample() -> Node:
	if len(possibilities) == 0:
		return null
	return Random.sample(possibilities)
