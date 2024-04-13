extends Node
class_name Main


@onready var tree: SceneTree = get_tree()
@onready var container: Control = $"PrimaryCanvas/SafeMarginContainer"


## The possible states the game can be in.
enum Stage {
	NONE = 0,
	MENU = 1,
	OPTIONS = 2,
	GAME = 3,
}

## The [Stage] the game is currently in.
##
## Changing this will automatically destroy and build the relevant scenes.
var current_stage: Stage:
	get:
		return current_stage
	set(value):
		# Do not rebuild scenes if the stage is set to the value it's already set to
		if value == current_stage:
			return
		# Destroy the current scenes
		match current_stage:
			Stage.MENU:
				destroy_menu()
		# Update the current stage
		current_stage = value
		# Build the next scenes
		match current_stage:
			Stage.MENU:
				build_menu()

## The [Stage] that [field current_stage] should be set to upon starting the game.
@export var starting_stage: Stage


## The main menu scene.
const SCENE_MENU: PackedScene = preload("res://scenes/interface/main_menu.tscn")

## The main menu node.
var scene_menu: MainMenu = null

## Destroy the main menu.
func destroy_menu() -> void:
	scene_menu.queue_free()
	scene_menu = null

## Build the main menu.
func build_menu() -> void:
	scene_menu = SCENE_MENU.instantiate()
	scene_menu.selected_play.connect(_on_menu_selected_play)
	scene_menu.selected_options.connect(_on_menu_selected_options)
	container.add_child(scene_menu)



func _ready() -> void:
	current_stage = starting_stage

func _on_menu_selected_play() -> void:
	current_stage = Stage.GAME

func _on_menu_selected_options() -> void:
	current_stage = Stage.OPTIONS
