@icon("res://behaviours/summoning_recipe.svg")
extends Node
class_name SummoningRecipe


## A [Node] describing a possible ingredients that can be performed with the [SummoningCircle].


## Emitted when [method do_match] is called, and the [field ingredients] is successfully matched.
signal matched(match: Match)


## How [Sacrificable]s should be matched.
@export var mode := Mode.NONE

## Which [Sacrificable]s should be matched.
@export var ingredients: Array[StringName] = []


func get_match(inputs: Array[Node2D]) -> Match:
	var matched_ingredients: Array[Sacrificable] = []
	# Find the ingredients
	for ingredient in ingredients:
		var matched_this = false
		for input in inputs:
			if input == null:
				continue
			for _sacrificable in input.find_children("*", "Sacrificable", true, false):
				var sacrificable: Sacrificable = _sacrificable as Sacrificable
				if sacrificable in matched_ingredients:
					continue
				if sacrificable.kind == ingredient:
					matched_ingredients.push_back(sacrificable)
					matched_this = true
					break
			if matched_this:
				break
		if not matched_this:
			matched_ingredients.push_back(null)
	# Use one of the various modes
	match mode:
		Mode.NONE:
			return null
		Mode.ANY:
			if matched_ingredients.any(func(value): return value != null):
				return Match.create(matched_ingredients)
			else:
				return null
		Mode.ALL:
			if matched_ingredients.all(func(value): return value != null):
				return Match.create(matched_ingredients)
			else:
				return null
		_:
			# Static analysis go home you're drunk
			return null


func do_match(inputs: Array[Node2D]) -> Match:
	var m = get_match(inputs)
	if m != null:
		matched.emit(m)
	return m


class Match:
	var sacrificables: Array[Sacrificable]

	static func create(s: Array[Sacrificable]) -> Match:
		var this = Match.new()
		this.sacrificables = s
		return this


enum Mode {
	## Never match the ingredients.
	NONE = 0,
	## Match the ingredients if a single one of the sacrificables is matched. 
	ANY = 1,
	## Match the ingredients if all the sacrificables are matched, even if more are present.
	ALL = 2,
}
