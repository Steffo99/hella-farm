extends Area2D
class_name Cursor

## A [CharacterBody2D] syncing its position with the mouse on each physics timestep.


signal dragged(node: Draggable)
signal dropped(node: Draggable)


@onready var game: MainGame = MainGame.get_via_group(self)
@onready var gold_display: GoldDisplay = %"GoldDisplay"
@onready var cheat_gold_spawner: Spawner = %"CheatGoldSpawner"

var dragging: Draggable = null


static func get_via_group(node: Node) -> Cursor:
	var result = node.get_tree().get_nodes_in_group("cursor")
	if result.is_empty():
		return null
	return result[0]


func find_closest_target() -> Draggable:
	var areas = get_overlapping_areas()
	var min_distance: float = INF
	var to_drag: Node = null
	for area in areas:
		if not area is Draggable:
			continue
		var distance = position.distance_to(area.position)
		if distance < min_distance:
			min_distance = distance
			to_drag = area
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
		if is_instance_valid(target):
			target.drop()
			dropped.emit(target)
		else:
			dropped.emit(null)

func log_dragging() -> void:
	Log.p(self, "Dragging: %s" % dragging)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				drag()
			else:
				drop()

func _process(_delta: float) -> void:
	# Determine mouse cursor shape
	if dragging:
		Input.set_default_cursor_shape(Input.CURSOR_DRAG)
	elif has_overlapping_areas():
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _physics_process(_delta: float) -> void:
	position += (game.camera.get_global_mouse_position() - global_position)
	if Input.is_action_pressed(&"cheat_gold"):
		cheat_gold_spawner.spawn()
