extends Node2D
class_name Collectable


signal collected


@export var tag: StringName


func _on_mouse_area_mouse_entered() -> void:
	collected.emit(tag)

func _on_collected(t: StringName) -> void:
	Log.p(self, "Collected: %s" % t)
