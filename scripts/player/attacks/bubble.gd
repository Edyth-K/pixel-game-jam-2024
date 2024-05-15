extends Area2D

var level = 1
var hp = 1 # hp of projectile; how many enemies 1 projectile can hit
var speed = 750
var damage = 5
var knockback_amount = 100
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

signal remove_from_array(object)

# adds spray effect to the bubble
var offset = randf_range(-5,5)

func _ready():
	angle = global_position.direction_to(target).rotated(deg_to_rad(offset))

	# rotation for attacks that need to be rotated to face target (like arrows)
	# rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			hp = 1
			speed = 750
			damage = 5
			knockback_amount = 100
			attack_size = 1.0
	
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
		queue_free()

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()

# TODO: bubble pop animation on queue_free() call?
