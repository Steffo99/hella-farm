extends Control
class_name MainMenu


## Emitted when the player has clicked on the Play button.
signal selected_play

## Emitted when the player has clicked on the Options button.
signal selected_options


func _on_play_pressed() -> void:
	selected_play.emit()

func _on_options_pressed() -> void:
	selected_options.emit()
