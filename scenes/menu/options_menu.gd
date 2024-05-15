extends Control
@onready var back_button = $MarginContainer/VBoxContainer/Back_Button as Button
const MENU = preload("res://scenes/menu/menu.tscn") as PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connecting_signals()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func handle_connecting_signals():
	back_button.button_down.connect(_on_back_button_pressed)

func _on_back_button_pressed():
	get_tree().change_scene_to_packed(MENU)
