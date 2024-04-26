extends PanelContainer
class_name GoldDisplay


@onready var label: Label = %"Label"
@onready var animator: AnimationPlayer = %"Animator"


func set_text(value: int) -> void:
	label.text = "%d €" % value

func increase(value: int):
	set_text(value)
	animator.stop()
	animator.play(&"increase")

func decrease(value: int):
	set_text(value)
	animator.stop()
	animator.play(&"decrease")

func change(new: int, old: int):
	if new > old:
		increase(new)
	elif old > new:
		decrease(new)
