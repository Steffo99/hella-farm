extends Node2D
class_name SacrificeStone

## The sacrificial stone where entities can be placed on.  
##
## Entities use [MovementHunter] to move towards the center of the stone.


## Emitted when the sacrifice on top of the stone changes.
signal sacrifice_changed(entity: PhysicsBody2D, type: Enums.MonsterType)

## The entity currently on top of the stone.
var entity: PhysicsBody2D


func _on_tracked(body: PhysicsBody2D):
	# If a entity is dragged on top of the SacrificeStone while another entity is already on top of it, ignore the capture and let the collision resolve instead
	if entity != null:
		return
	# Make sure the entity is sacrificable, and if it is, lock it in and emit [signal sacrifice_changed].
	var types: Array = body.find_children("*", "Sacrificable", false, false)
	for type in types:
		entity = body
		sacrifice_changed.emit(body)
		break

func _on_untracked(body: PhysicsBody2D):
	if body == entity:
		entity = null
		sacrifice_changed.emit(null)
