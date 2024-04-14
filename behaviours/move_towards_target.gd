extends MoveTowards
class_name MoveTowardsTarget

@export var target: Node2D


func get_followed_global_position():
	return target.global_position
