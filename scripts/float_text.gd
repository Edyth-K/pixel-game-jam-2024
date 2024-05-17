extends Node2D
@onready var label = $Label

var opacity = 1

func _ready():
	pass

func _physics_process(delta):
	label.modulate = Color(1,1,1,opacity)
	opacity *= .98

func _on_timer_timeout():
	queue_free() # Replace with function body.
