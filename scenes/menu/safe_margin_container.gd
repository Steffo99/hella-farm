extends MarginContainer
class_name SafeMarginContainer

## Ensures its children don't overlap any display cutout, such as the bezels of a mobile phone.


## Minimum pixel margin that the UI should have from the left side of the screen.
@export var min_margin_left: int

## Minimum pixel margin that the UI should have from the right side of the screen.
@export var min_margin_right: int

## Minimum pixel margin that the UI should have from the top side of the screen.
@export var min_margin_top: int

## Minimum pixel margin that the UI should have from the bottom side of the screen.
@export var min_margin_bottom: int


var margin_left: int:
	get:
		return get_theme_constant("margin_left")
	set(value):
		add_theme_constant_override("margin_left", value)

var margin_right: int:
	get:
		return get_theme_constant("margin_right")
	set(value):
		add_theme_constant_override("margin_right", value)

var margin_top: int:
	get:
		return get_theme_constant("margin_top")
	set(value):
		add_theme_constant_override("margin_top", value)

var margin_bottom: int:
	get:
		return get_theme_constant("margin_bottom")
	set(value):
		add_theme_constant_override("margin_bottom", value)



func _ready():
	# Cutouts are broken on desktop platforms...
	if len(DisplayServer.get_display_cutouts()) == 0:
		margin_left = min_margin_left
		margin_right = min_margin_right
		margin_top = min_margin_top
		margin_bottom = min_margin_bottom
	else:
		var screen: Vector2i = DisplayServer.screen_get_size()
		var rect: Rect2i = DisplayServer.get_display_safe_area()
		margin_left = max(min_margin_left, rect.position.x)
		margin_right = max(min_margin_right, screen.x - rect.end.x)
		margin_top = max(min_margin_top, rect.position.y)
		margin_bottom = max(min_margin_bottom, screen.y - rect.end.y)
