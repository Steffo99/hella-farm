extends Node2D
class_name Collectable


@export var tag: StringName


signal collected(tag: StringName)


func _on_mouse_area_mouse_entered() -> void:
	collected.emit()

func _on_collected(t: StringName) -> void:
	Log.p(self, "Collected: %s" % t)
