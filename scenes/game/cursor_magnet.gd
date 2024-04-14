extends Area2D
class_name CursorMagnet


signal dragged(node: Draggable)
signal dropped(node: Draggable)


func find_closest_target() -> Draggable:
	var bodies = get_overlapping_bodies()
	var min_distance: float = INF
	var to_drag: Node = null
	for body in bodies:
		for target in body.find_children("Draggable", "Draggable", false, false):
			var distance = position.distance_to(target.position)
			if distance < min_distance:
				min_distance = distance
				to_drag = target
	return to_drag


var dragging: Draggable = null

func drag():
	var target = find_closest_target()
	if target:
		dragging = target
		target.drag()
		dragged.emit(target)

func drop():
	if dragging:
		var target = dragging
		dragging = null
		target.drop()
		dropped.emit(target)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				drag()
			else:
				drop()

func _on_dragged(node: Draggable) -> void:
	Log.p(self, "Dragged: %s" % node)

func _on_dropped(node: Draggable) -> void:
	Log.p(self, "Dropped: %s" % node)

func _on_move(movement: Vector2) -> void:
	position += movement
