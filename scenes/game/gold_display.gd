extends PanelContainer
class_name GoldDisplay


@onready var label: Label = %"Label"
@onready var animator: AnimationPlayer = %"Animator"


func set_text(value: int) -> void:
	label.text = "%d €" % value


func display(value: int):
	set_text(value)
	animator.stop()
	animator.play(&"collect")
