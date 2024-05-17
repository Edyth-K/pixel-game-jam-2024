extends Node2D

@onready var player = $Player
@onready var color_rect = $CanvasLayer/ColorRect
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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	update_bg()

func update_bg():
	#print(str(position.y))
	var y = player.position.y
	var r = 0.427
	var g = 0.537
	var b = 0.98
	
	if y < H_MAX:
		# lightest shade of water
		color_rect.color = Color(R_MAX,G_MAX,B_MAX,1)
	elif y > H_MIN:
		# darkest shade of water
		color_rect.color = Color(R_MIN,G_MIN,B_MIN,1)
	else:
		y = (y-H_MAX) / (H_MIN-H_MAX) * 1
		r = y * 0.004 + (1 - y) * r
		g = y * 0.016 + (1 - y) * g
		b = y * 0.059 + (1 - y) * b
		color_rect.color = Color(r,g,b,1)

func dmg_text(damage, spawn_position):
	var text = float_text.instantiate()
	var offset_x = randf_range(-40,40)
	var offset_y = randf_range(-50,-40)
	text.position = spawn_position + Vector2(offset_x, offset_y)
	text.get_node("Label").text = str(damage)
	add_child(text)
	
# TODO: environmental objects? 
# maybe some bubble groups?
