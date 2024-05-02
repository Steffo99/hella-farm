extends Node2D
class_name MainGame


@export var default_spawn_parent: Node2D

@onready var camera: GameCamera = $"GameCamera"
@onready var inventory: Inventory = %"Inventory"
@onready var cursor: Cursor = %"Cursor"
@onready var music: Music = %"Music"

var time_elapsed: float = 0.0
var recipe_timings := {}


static func get_via_group(node: Node) -> MainGame:
	var result = node.get_tree().get_nodes_in_group("game")
	if result.is_empty():
		return null
	return result[0]


func _ready():
	# Set up the gold display
	var gold_counter = inventory.get_counter(&"Gold")
	gold_counter.changed.connect(cursor.gold_display.change)
	cursor.gold_display.set_text(gold_counter.value)

func _physics_process(delta: float) -> void:
	time_elapsed += delta

func _on_recipe_matched(_m: SummoningRecipe.Match, recipe: SummoningRecipe) -> void:
	var timing = recipe_timings.get(recipe.name)
	if timing == null:
		recipe_timings[recipe.name] = time_elapsed
		Log.p(self, "Recipe %s first completed in: %f s" % [recipe.name, time_elapsed])
	# Quick hack for now
	match recipe.name:
		"FiveSheep":
			music.enable_layer_1()
			music.do_sync()
		"FiveImps":
			music.enable_layer_2()
		"ASkull":
			music.enable_layer_2()
		"FiveChupacabra":
			music.enable_layer_3()
		"FiveTopHats":
			music.enable_layer_3()
		"FiveMonocles":
			music.enable_layer_3()
