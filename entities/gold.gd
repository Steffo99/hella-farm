extends Node2D
class_name Gold


func _on_move(movement: Vector2) -> void:
	Log.p(self, "%s" % movement)
	position += movement
