extends CharacterBody2D
class_name Cursor

## A [CharacterBody2D] syncing its position with the mouse on each physics timestep.


@onready var game := MainGame.get_ancestor(self)


func _physics_process(_delta: float) -> void:
	move_and_collide(game.camera.get_global_mouse_position() - global_position)
