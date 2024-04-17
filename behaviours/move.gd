@icon("res://behaviours/move.svg")
extends Node2D
class_name Move


signal move(norm: Vector2)

## Whether this component should emit [signal move].
@export var enabled: bool = true
