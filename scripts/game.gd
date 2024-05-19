extends Node2D
# TODO: fix bg ColorRect covers UI
@onready var player = $Player
@onready var color_rect = $CanvasLayer/ColorRect
@onready var pause_menu = $Pause/pause_menu as Control

var float_text = preload("res://scenes/float_text.tscn")
# default variables to adjust background colour
const R_MIN = 0.004
const G_MIN = 0.016
const B_MIN = 0.059
const R_MAX = 0.427
const G_MAX = 0.537
const B_MAX = 0.98
const H_MAX = -30000
const H_MIN = 10000

var pauseable = true

func _input(event):
	if event.is_action_pressed("pause") and pauseable == true:
		get_tree().paused = true
		pause_menu.show()
		
func unpause():
	pause_menu.hide()
	get_tree().paused = false

func dmg_text(damage, spawn_position):
	var text = float_text.instantiate()
	var offset_x = randf_range(-40,40)
	var offset_y = randf_range(-50,-40)
	text.position = spawn_position + Vector2(offset_x, offset_y)
	text.get_node("Label").text = str(damage)
	add_child(text)
	
# TODO: environmental objects? 
# maybe some bubble groups?
