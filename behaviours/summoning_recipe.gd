@icon("res://behaviours/summoning_recipe.svg")
extends Node
class_name SummoningRecipe


## A [Node] describing a possible recipe that can be performed with the [SummoningCircle].


## Emitted when [method do_match] is called, and the [field recipe] is successfully matched.
signal matched


## How [Sacrificable]s should be matched.
@export var mode := Mode.NONE

## Which [Sacrificable]s should be matched.
@export var recipe: Array[StringName] = []


func check_match(inputs: Array[StringName]) -> bool:
	var matching: Array[bool] = recipe.map(func(): return false)
	# This is awful, but I am too lazy to implement something better
	# why is there no enumerate Q_Q
	for input in inputs:
		var idx = 0
		for matchable in recipe:
			if input == matchable and not matching[idx]:
				matching[idx] = true
				continue
			idx += 1
	# Use one of the various modes
	# why do i have to do this
	match mode:
		Mode.NONE:
			return false
		Mode.ANY:
			return matching.any(func(value): return value)
		Mode.ALL:
			return matching.all(func(value): return value)
		Mode.EXACT:
			return matching.all(func(value): return value) and len(inputs) == len(recipe)
		_:
			# Static analysis go home you're drunk
			return false


func do_match(inputs: Array[StringName]) -> void:
	if check_match(inputs):
		matched.emit()


enum Mode {
	## Never match the recipe.
	NONE = 0,
	## Match the recipe if a single one of the sacrificables is matched. 
	ANY = 1,
	## Match the recipe if all the sacrificables are matched, even if more are present.
	ALL = 2,
	## Match the recipe if all the sacrificables are matched AND there are no other sacrificables present.
	EXACT = 3,
}
