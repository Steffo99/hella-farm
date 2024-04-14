extends Camera2D
class_name GameCamera


## Get the first possible [GameCamera] instance by climbing the scene tree one ancestor at a time.
static func get_ancestor(start: Node) -> GameCamera:
	var current = start
	while current is Node:
		if current is GameCamera:
			return current
		current = current.get_parent()
	return null
