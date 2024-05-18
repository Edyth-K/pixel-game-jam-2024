extends Area2D
@onready var player = get_tree().get_first_node_in_group("player")

var level = 1
var hp = 2 # hp of projectile; how many enemies 1 projectile can hit
var speed = 350
var damage = 5
var knockback_amount = 100
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

signal remove_from_array(object)


# urchin specific
var is_popped = false
# adds spray effect to the urchin
var offset = randf_range(-90,90)
var down_velocity = -5
var grav = -.2

func _ready():
	angle = Vector2.UP.rotated(deg_to_rad(offset))
	#animated_sprite_2d.set_frame_and_progress(0,0)
	# rotation for attacks that need to be rotated to face target (like arrows)
	# rotation = angle.angle() + deg_to_rad(135)
	print ("urchin damage: " + str(damage))
	print ("urchin level: " + str(level))
	match level:
		1:
			hp = 2
			speed = 350
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.attack_size)
		2:
			hp = 2
			speed = 350
			damage = 7
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.attack_size)
			
	
	var tween = create_tween()
	# tween is a way of "animating" node properties
	# tween_property ( node to change, property of node, end result of value, time to complete)
	# set_trans and set_ease are modifiers that affect how it happens I think?
	tween.tween_property(self, "scale", Vector2(1.5,1.5)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
		# Add the gravity.
	down_velocity -= grav
	var vector_gravity = Vector2(0, down_velocity)
	position += (angle * speed * delta) + (vector_gravity)
	# urchin Specific Mechanics:
	if speed > 0:
		speed -= speed*0.04
	# despawn urchin when it slows down enough or if it travels far enough
	if speed <= 5:
		emit_signal("remove_from_array", self)
		queue_free()

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()
		#queue_free()

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()

func _on_animated_sprite_2d_animation_finished():
	queue_free() # Replace with function body.
