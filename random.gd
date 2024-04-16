class_name Random

## Random number generator utilities

## Lazy init [RandomNumberGenerator].
static var rng: RandomNumberGenerator = null:
	get:
		if rng == null:
			rng = RandomNumberGenerator.new()
		return rng
	set(value):
		rng = value


static func sample(array: Array[Variant], imin = null, imax = null) -> Variant:
	if imin == null:
		imin = 0
	if imax == null:
		imax = len(array) - 1
	var idx = rng.randi_range(imin, imax)
	return array[idx]
