extends CharacterBody2D
@onready var player = get_node("/root/Game/Player")
@onready var animated_sprite = $AnimatedSprite2D

var SPEED = 1


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * SPEED
	if direction.x > 0:
		animated_sprite.flip_h = true
	elif direction.x < 1:
		animated_sprite.flip_h = false

	move_and_slide()
