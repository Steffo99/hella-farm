extends Node2D
class_name MainGame


@onready var camera: GameCamera = $"GameCamera"
@onready var default_spawn_parent: Node2D = %"DefaultSpawnParent"
@onready var inventory: Inventory = %"Inventory"
@onready var cursor: Cursor = %"Cursor"


static func get_via_group(node: Node) -> MainGame:
	var result = node.get_tree().get_nodes_in_group("game")
	if result.is_empty():
		return null
	return result[0]


func _ready():
	var gold_counter = inventory.get_counter(&"Gold")
	gold_counter.changed.connect(cursor.gold_counter.display.unbind(1))
	cursor.gold_counter.set_text(gold_counter.value)
