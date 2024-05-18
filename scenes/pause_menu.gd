extends Control
@onready var pause_menu = $"."
@onready var game = $"../.."

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("pause") and game.pauseable == true:
		pause_menu.hide()
		get_tree().paused = false
		get_viewport().set_input_as_handled()
		
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
