extends Node
class_name Music


@onready var layer_1: AudioStreamPlayer = %"Layer1"
@onready var layer_2: AudioStreamPlayer = %"Layer2"
@onready var layer_3: AudioStreamPlayer = %"Layer3"


func do_sync():
	var position = layer_1.get_playback_position()
	layer_1.stop()
	layer_2.stop()
	layer_3.stop()
	layer_1.play(position)
	layer_2.play(position)
	layer_3.play(position)

func enable_layer_1():
	layer_1.volume_db = 0

func enable_layer_2():
	layer_2.volume_db = 0

func enable_layer_3():
	layer_3.volume_db = 0


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("music_toggle"):
		var bus = AudioServer.get_bus_index(&"Music")
		var status = AudioServer.is_bus_mute(bus)
		AudioServer.set_bus_mute(bus, !status)
	if Input.is_action_just_pressed("sound_toggle"):
		var bus = AudioServer.get_bus_index(&"Sounds")
		var status = AudioServer.is_bus_mute(bus)
		AudioServer.set_bus_mute(bus, !status)
