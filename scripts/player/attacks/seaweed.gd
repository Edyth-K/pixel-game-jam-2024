extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer

@onready var player = get_tree().get_first_node_in_group("player")
var level = 1
var damage = 5
var attack_size = 1.0
var offset = 100
var animation_played = false

signal remove_from_array(object)
# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play("slash")
	match level:
		1:
			damage = 5
		2:
			damage = 10
		3:
			damage = 15
		4:
			damage = 20
	match player.attack_size:
		0:
			attack_size = 1.0 * (1 + player.attack_size)
			offset = 20
		0.5:
			attack_size = 1.0 * (1 + player.attack_size)
			offset = 40
		1.0:
			attack_size = 1.0 * (1 + player.attack_size)
			offset = 60
		1.5:
			attack_size = 1.0 * (1 + player.attack_size)
			offset = 80
		2.0:
			attack_size = 1.0 * (1 + player.attack_size)
			offset = 100
	if position.x > player.position.x:
		position.x += offset
	else:
		position.x -= offset
	scale.x *= 2 + attack_size
	scale.y *= 3
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _on_animated_sprite_2d_animation_finished():
	
	queue_free() # Replace with function body.

func _on_timer_timeout():
	animated_sprite_2d.play("slash")
