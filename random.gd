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
