extends Sampler
class_name SamplerRandom


## Sample a random reference from the array.


@export var possibilities: Array = []


func sample() -> Object:
	if len(possibilities) == 0:
		return null
	return Random.sample(possibilities)
