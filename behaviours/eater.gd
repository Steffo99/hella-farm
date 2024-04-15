extends Area2D
class_name Eater


signal eaten(edible: Edible)


@export var tag: StringName



func _on_body_entered(body: Node2D) -> void:
	var edibles: Array = body.find_children("Edible", "Edible", false, false)
	for edible in edibles:
		if edible.tag == tag:
			eaten.emit(edible)
			edible.eat()


func _on_eaten(edible: Edible) -> void:
	Log.p(self, "Eaten: %s" % edible)
