extends CharacterBody2D
class_name Cursor

## A [CharacterBody2D] syncing its position with the mouse on each physics timestep.


@onready var game := MainGame.get_via_group(self)


static func get_via_group(node: Node) -> MainGame:
	var result = node.get_tree().get_nodes_in_group("cursor")
	if result.is_empty():
		return null
	return result[0]


func _physics_process(_delta: float) -> void:
	move_and_collide(game.camera.get_global_mouse_position() - global_position)
