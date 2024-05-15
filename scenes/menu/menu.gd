extends Control
@onready var start = $VBoxContainer/Start as Button
@onready var options = $VBoxContainer/Options as Button
@onready var quit = $VBoxContainer/Quit as Button
var OPTIONS_MENU = load("res://scenes/menu/options_menu.tscn")
var GAME = load("res://scenes/game.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connecting_signals()

func _on_options_pressed():
	get_tree().change_scene_to_packed(OPTIONS_MENU)

func _on_start_pressed():
	get_tree().change_scene_to_packed(GAME)

func _on_quit_pressed():
	get_tree().quit()

func handle_connecting_signals():
	start.grab_focus()
	start.button_down.connect(_on_start_pressed)
	options.button_down.connect(_on_options_pressed)
	quit.button_down.connect(_on_quit_pressed)
