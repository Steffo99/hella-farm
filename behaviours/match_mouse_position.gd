extends Node
class_name MatchMousePosition


@onready var parent: Node2D = get_parent()
@onready var game := MainGame.get_ancestor(self)


func _physics_process(_delta: float) -> void:
	var global_mouse_position: Vector2 = game.camera.get_global_mouse_position()
	parent.global_position = global_mouse_position
