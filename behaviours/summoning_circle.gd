@icon("res://behaviours/summoning_circle.svg")
extends Node2D
class_name SummoningCircle


## Emitted when a recipe is matched, before the components are sacrificed.
signal recipe_matched(m: SummoningRecipe.Match, recipe: SummoningRecipe)


## The [SacrificeStone]s part of this summoning circle.
var stones: Array[SacrificeStone] = []

## The [SummoningRecipe]s performable by this summoning circle.
var recipes: Array[SummoningRecipe] = []

var _recipes_matched_signals: Array[Callable] = []


## Refresh the value of [field stones], and reconnect signals accordingly.
func refresh_stones() -> void:
	# Disconnect signals
	for stone in stones:
		if stone == null:
			return
		if stone.sacrifice_changed.is_connected(_on_sacrifice_changed):
			stone.sacrifice_changed.disconnect(_on_sacrifice_changed)
	# Find the new stones
	stones.assign(
		find_children("*", "SacrificeStone", true, false)
	)
	# Reconnect signals
	for stone in stones:
		stone.sacrifice_changed.connect(_on_sacrifice_changed)

## Refresh the value of [field recipes], and reconnect signals accordingly.
func refresh_recipes() -> void:
	# Disconnect signals
	var idx: int = 0
	for recipe in recipes:
		var callable = _recipes_matched_signals[idx]
		if recipe.matched.is_connected(callable):
			recipe.matched.disconnect(callable)
		idx += 1
	_recipes_matched_signals = []
	# Find the new recipes
	recipes.assign(
		find_children("*", "SummoningRecipe", true, false)
	)
	# Reconnect signals
	for recipe in recipes:
		var callable = _on_recipe_matched.bind(recipe)
		recipe.matched.connect(callable)
		_recipes_matched_signals.push_back(callable)


func _ready() -> void:
	refresh_stones()
	refresh_recipes()

func _on_sacrifice_changed(_entity: Node2D) -> void:
	var entities: Array[Node2D] = []
	entities.assign(
		stones.map(func(stone): return stone.entity)
	)
	for recipe in recipes:
		if recipe.do_match(entities):
			break

func _on_recipe_matched(m: SummoningRecipe.Match, recipe: SummoningRecipe) -> void:
	recipe_matched.emit(m, recipe)
	for sacrificable in m.sacrificables:
		sacrificable.sacrifice()
