extends Area2D
class_name Cursor

## A [CharacterBody2D] syncing its position with the mouse on each physics timestep.


signal dragged(node: Draggable)
signal dropped(node: Draggable)


@onready var game := MainGame.get_via_group(self)

var dragging: Draggable = null


static func get_via_group(node: Node) -> MainGame:
	var result = node.get_tree().get_nodes_in_group("cursor")
	if result.is_empty():
		return null
	return result[0]


func find_closest_target() -> Draggable:
	var bodies = get_overlapping_bodies()
	var min_distance: float = INF
	var to_drag: Node = null
	for body in bodies:
		for target in body.find_children("*", "Draggable", true, false):
			var distance = position.distance_to(target.position)
			if distance < min_distance:
				min_distance = distance
				to_drag = target
	return to_drag

func drag():
	var target = find_closest_target()
	if target and not dragging:
		dragging = target
		target.drag(self)
		dragged.emit(target)

func drop():
	if dragging:
		var target = dragging
		dragging = null
		target.drop(self)
		dropped.emit(target)

func log_dragging() -> void:
	Log.p(self, "Dragging: %s" % dragging)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				drag()
			else:
				drop()

func _physics_process(_delta: float) -> void:
	position += (game.camera.get_global_mouse_position() - global_position)
