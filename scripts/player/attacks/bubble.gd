extends Area2D
@onready var player = get_tree().get_first_node_in_group("player")

var level = 1
var hp = 1 # hp of projectile; how many enemies 1 projectile can hit
var speed = 750
var damage = 5
var knockback_amount = 100
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO
@onready var animated_sprite_2d = $AnimatedSprite2D

signal remove_from_array(object)

# bubble specific
var is_popped = false
# adds spray effect to the bubble
var offset = randf_range(-5,5)

func _ready():
	angle = global_position.direction_to(target).rotated(deg_to_rad(offset))
	animated_sprite_2d.set_frame_and_progress(0,0)
	# rotation for attacks that need to be rotated to face target (like arrows)
	# rotation = angle.angle() + deg_to_rad(135)
	print ("bubble damage: " + str(damage))
	print ("bubble level: " + str(level))
	match level:
		1:
			hp = 1
			speed = 750
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.attack_size)
		2:
			hp = 1
			speed = 750
			damage = 7
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.attack_size)
		3:
			hp = 1
			speed = 750
			damage = 9
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.attack_size)
		4:
			hp = 1
			speed = 750
			damage = 11
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
	position += angle * speed * delta
	
	# Bubble Specific Mechanics:
	if speed > 0:
		speed -= speed*0.04
	# despawn bubble when it slows down enough or if it travels far enough
	if speed <= 5:
		emit_signal("remove_from_array", self)
		pop()
		#queue_free()

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array", self)
		pop()
		#queue_free()

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	pop()


func pop():
	remove_from_group("attack")
	if is_popped == false:
		is_popped = true
		animated_sprite_2d.play("pop")

func _on_animated_sprite_2d_animation_finished():
	queue_free() # Replace with function body.
