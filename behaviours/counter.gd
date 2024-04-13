extends Node
class_name Counter


signal changed(old: int, new: int)


@export var starting_value: int

var value: int


func _ready():
	value = starting_value

func change(amount: int):
	var old = value
	value = amount
	changed.emit(old, value)

func increase(amount: int = 1):
	if amount < 0:
		Log.w(self, "Increasing a counter by a negative value.")
	change(value + amount)

func decrease(amount: int = 1):
	if amount < 0:
		Log.w(self, "Decreasing a counter by a negative value.")
	change(value - amount)
