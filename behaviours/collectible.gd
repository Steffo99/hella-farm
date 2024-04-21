@icon("res://behaviours/collectible.svg")
extends Node
class_name Collectible


## How many of that item this [Collectible] represents.
@export var quantity: int = 1

## What kind of item this [Collectible] represents.
@export var kind: StringName = &""


@onready var game: MainGame = MainGame.get_via_group(self)


func apply():
	game.inventory.get_counter(kind).increase(quantity)