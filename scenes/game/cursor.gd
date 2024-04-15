extends Node2D
class_name Cursor

## A [Node2D] syncing its position with the mouse on each physics timestep.


@onready var game := MainGame.get_ancestor(self)


func _physics_process(_delta: float) -> void:
	global_position = game.camera.get_global_mouse_position()
