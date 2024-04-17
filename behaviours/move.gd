@icon("res://behaviours/move.svg")
extends Node2D
class_name Move


signal move(norm: Vector2)
signal move_toggled(value: bool)
signal move_enabled
signal move_disabled

## Whether this component should emit [signal move].
@export var enabled: bool = true:
	get:
		return enabled
	set(value):
		if enabled != value:
			enabled = value
			move_toggled.emit(value)
			if value:
				move_enabled.emit()
			else:
				move_disabled.emit()
