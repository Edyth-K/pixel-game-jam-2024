extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var hp = $HP
#@onready var hurtbox = $Hurtbox

var health = 100.0
var speed = 250.0
var xp = 0
var level = 1
var collected_exp = 0 # to handle overflow
# Attacks
var bubble = preload("res://scenes/player/attacks/bubble.tscn")

# AttackNodes
@onready var bubble_timer = get_node("%BubbleTimer")
@onready var bubble_attack_timer = get_node("%BubbleAttackTimer")

# Bubble
var bubble_ammo = 0
var bubble_baseammo = 1
var bubble_attackspeed = 1.5
var bubble_level = 1

# Enemy Related (track closest enemy)
var enemy_close = []

func _ready():
	attack()

func attack():
	if bubble_level > 0:
		bubble_timer.wait_time = bubble_attackspeed
		if bubble_timer.is_stopped():
			bubble_timer.start()

func _physics_process(_delta):
	
	# TODO: replace HP label with HP bar
	# also XP
	hp.text = ("HP: " + str(int(health)) + "\n" + str(level) + " ")
	hp.text += ("XP: " + str(int(xp)) + "/" + str(exp_to_next_level()) + "\n")
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * speed
	move_and_slide()

	# rotate sprite based on direction
	if velocity.length() == 0.0:
		# staying still
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
	

func _on_hurt_box_hurt(damage, _angle, _knockback):
	health -= damage
	 # Replace with function body.

func _on_bubble_timer_timeout():
	# load ammo
	bubble_ammo += bubble_baseammo
	bubble_attack_timer.start()

func _on_bubble_attack_timer_timeout():
	# shoot ammo
	if bubble_ammo > 0:
		var bubble_attack = bubble.instantiate()
		bubble_attack.position = position
		bubble_attack.target = get_closest_target()
		bubble_attack.level = bubble_level
		add_child(bubble_attack)
		bubble_ammo -= 1
		if bubble_ammo > 0:
			bubble_attack_timer.start()
		else:
			bubble_attack_timer.stop()

func get_closest_target():
	var lowest_distance = 8192.0
	var closest
	if enemy_close.size() > 0:
		for enemy in enemy_close:
			var distance = global_position.distance_to(enemy.global_position)
			if distance <= lowest_distance:
				lowest_distance = distance
				closest = enemy
		return closest.global_position
	else:
		return Vector2.UP

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP

func _on_enemy_detection_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detection_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)
		
# Experience and Level Functions
func gain_exp(amount):
	var required = exp_to_next_level()
	collected_exp += amount
	if xp + collected_exp >= required:
		collected_exp -= required - xp
		level += 1
		# TODO: remove bubble upgrade, put somewhere else
		# maybe make dedicated level up function for upgrades?
		bubble_baseammo += 1
		xp = 0
		gain_exp(0)
	else:
		xp += collected_exp
		collected_exp = 0
# return exp to next level
func exp_to_next_level():
	var exp_to_next = level
	if level < 10:
		exp_to_next = level * 5
	elif level < 20:
		exp_to_next = 50 + (level - 9) * 8
	else:
		exp_to_next = 100 + (level - 19) * 12
	return exp_to_next
