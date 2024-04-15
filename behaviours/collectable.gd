@icon("res://behaviours/collectable.svg")
extends Area2D
class_name Collectable

## Emits [signal collected] when the mouse enters the given [CollisionShape2D].


signal collected

@export var qty: int = 1
@export var tag: StringName = &""


func _on_mouse_entered() -> void:
	collected.emit(tag)

func _on_collected() -> void:
	Log.p(self, "Collected: %sx %s" % [qty, tag])
