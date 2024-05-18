extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer

@onready var player = get_tree().get_first_node_in_group("player")
var level = 1
var damage = 5
var attack_size = 1.0
var animation_played = false

signal remove_from_array(object)
# Called when the node enters the scene tree for the first time.
func _ready():
	print("seaweed attack")
	print(str(position))
	print(str(player.position))
	animated_sprite_2d.play("slash")
	match level:
		1:
			damage = 5
			attack_size = 1.0
		2:
			damage = 10
			attack_size = 2.0
	scale.x *= 3
	scale.y *= 3
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _on_animated_sprite_2d_animation_finished():
	print("delete seaweed")
	queue_free() # Replace with function body.

func _on_timer_timeout():
	animated_sprite_2d.play("slash")
