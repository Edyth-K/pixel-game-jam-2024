extends Control
@onready var start = $VBoxContainer/Start as Button
@onready var options = $VBoxContainer/Options as Button
@onready var quit = $VBoxContainer/Quit as Button
const OPTIONS_MENU = preload("res://scenes/menu/options_menu.tscn") as PackedScene
const GAME = preload("res://scenes/game.tscn") as PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connecting_signals()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
