extends MoveTowards
class_name MoveTowardsMouse

@onready var game := MainGame.get_ancestor(self)


func get_followed_global_position():
	return game.camera.get_global_mouse_position()
