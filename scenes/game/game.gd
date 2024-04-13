extends Node2D
class_name MainGame

## Emitted when the player has clicked on the Options button.
signal selected_exit


func _on_exit_pressed() -> void:
	selected_exit.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
