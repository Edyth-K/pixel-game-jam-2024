extends CharacterBody2D
@onready var player = get_node("/root/Game/Player")

var SPEED = 15

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * SPEED

	move_and_slide()
