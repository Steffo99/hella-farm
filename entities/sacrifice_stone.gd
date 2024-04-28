extends Node2D
class_name SacrificeStone


## Emitted when the sacrifice on top of the stone changes.
signal sacrifice_changed(entity: PhysicsBody2D, type: Enums.MonsterType)


var current_monster: PhysicsBody2D


func _on_tracked(body: PhysicsBody2D):
	# If a monster is dragged on top of the SacrificeStone while another monster is already on top of it, ignore the capture and let the collision resolve instead
	if current_monster != null:
		return
	# Make sure the monster is sacrificable, and if it is, lock it in and emit [signal sacrifice_changed].
	var types: Array = body.find_children("*", "Sacrificable", false, false)
	for type in types:
		current_monster = body
		sacrifice_changed.emit(current_monster)
		break

func _on_untracked(body: PhysicsBody2D):
	if body == current_monster:
		current_monster = null
		sacrifice_changed.emit(current_monster)
