extends Node2D
class_name Gold


@export var value: int = 1


func _on_move(movement: Vector2) -> void:
	position += movement

func _on_collected(tag: StringName) -> void:
	var game = MainGame.get_via_group(self)
	
	# TODO: Perhaps use a dictionary in game to store multiple currencies?
	match tag:
		&"Gold":
			game.gold_counter.increase(value)
	
	queue_free()
