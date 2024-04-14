extends Node2D
class_name Cloud

@onready var player = $"AnimationPlayer"
@onready var spawner = $"Spawner"

func _ready():
	spawner.spawn()
	var player = $"AnimationPlayer"
	player.play("fade_out")
	await player.animation_finished
	queue_free()


