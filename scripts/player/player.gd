extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var hp = $HP
@onready var hurtbox = $Hurtbox

var health = 100.0
const SPEED = 50.0

func _physics_process(delta):
	
	# TODO: replace HP label with HP bar
	hp.text = str(int(health))

	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * SPEED
	move_and_slide()

	# rotate sprite based on direction
	if velocity.length() == 0.0:
		# staying still
		#$AnimatedSprite2D.animation = "idle"
		animated_sprite.play("idle")
		animated_sprite.rotation = 0
	else:
		animated_sprite.play("move")
		# up
		if velocity.y < 0 and velocity.x == 0:
			animated_sprite.rotation_degrees = 0
		# up right
		elif velocity.y < 0 and velocity.x > 0:
			animated_sprite.rotation_degrees = 45
		# right
		elif velocity.y == 0 and velocity.x > 0:
			animated_sprite.rotation_degrees = 90
		# down right
		elif velocity.y > 0 and velocity.x > 0:
			animated_sprite.rotation_degrees = 135
		# down
		elif velocity.y > 0 and velocity.x == 0:
			animated_sprite.rotation_degrees = 180
		# down left
		elif velocity.y > 0 and velocity.x < 0:
			animated_sprite.rotation_degrees = 225
		# left
		elif velocity.y == 0 and velocity.x < 0:
			animated_sprite.rotation_degrees = 270
		# up right
		else:
			animated_sprite.rotation_degrees = 315
	

func _on_hurt_box_hurt(damage):
	health -= damage
	 # Replace with function body.
