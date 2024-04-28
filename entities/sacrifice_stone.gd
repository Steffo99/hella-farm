extends Node2D
class_name SacrificeStone


signal sacrifice_changed(entity: PhysicsBody2D, type: Enums.MonsterType)


var current_monster: PhysicsBody2D
var current_type: Enums.MonsterType = Enums.MonsterType.None


func _on_tracked(body: PhysicsBody2D):
	if current_monster != null:
		Log.w(self, "Captured two entities")
		return

	var types: Array = body.find_children("*", "MonsterType", false, false)
	for type in types:
		current_monster = body
		current_type = type.type
		sacrifice_changed.emit(current_monster, current_type)
		break

	if current_monster == null:
		Log.w(self, "Captured entity with no MonsterType")

func _on_untracked(body: PhysicsBody2D):
	if body == current_monster:
		current_monster = null
		current_type = Enums.MonsterType.None
		sacrifice_changed.emit(current_monster, current_type)
