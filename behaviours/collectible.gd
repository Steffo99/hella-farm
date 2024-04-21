@icon("res://behaviours/collectible.svg")
extends Node
class_name Collectible


## Marker class that stores the value of a collectible item.


## How many of that item this [Collectible] represents.
@export var quantity: int = 1

## What kind of item this [Collectible] represents.
@export var kind: StringName = &""