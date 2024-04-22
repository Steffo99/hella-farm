class_name Traversal


## Get the first possible [MainGame] instance by climbing the scene tree one ancestor at a time.
static func get_ancestors(start: Node) -> Array[Node]:
	var result: Array[Node] = []
	var current = start
	while current is Node:
		result.push_back(current)
		current = current.get_parent()
	return result
