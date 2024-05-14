extends CharacterBody2D
@onready var player = get_node("/root/Game/Player")
@onready var animated_sprite = $AnimatedSprite2D
@onready var label = $Label

var speed = 30
var health = 15

# _physics_process essentially called every frame
func _physics_process(delta):
	
	# for debugging, health display
	label.text = str(health)
	
	# move towards player
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	if direction.x > 0:
		animated_sprite.flip_h = true
	elif direction.x < 1:
		animated_sprite.flip_h = false

	move_and_slide()


func take_damage(damage):
	health -= damage
	
	if health <= 0:
		queue_free()
