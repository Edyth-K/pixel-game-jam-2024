extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var flash_on_hit_timer = $FlashOnHitTimer
@onready var hp = $HP

# GUI
@onready var xp_bar = $"../CanvasLayer/HUD/XP Bar/TextureProgressBar"
@onready var lvl_label = $"../CanvasLayer/HUD/XP Bar/lvlLabel"
@onready var lvl_panel = get_node("%LevelUp")
@onready var upg_options = get_node("%UpgradeOptions")
@onready var item_options = preload("res://scenes/item_option.tscn")
@onready var snd_lvl_up = get_node("%snd_levelup")

var xp = 0
var level = 1
var collected_exp = 0 # to handle overflow
signal xp_gained(growth_data)
# Attacks
var urchin = preload("res://scenes/player/attacks/urchin.tscn")
var bubble = preload("res://scenes/player/attacks/bubble.tscn")
var lightning = preload("res://scenes/player/attacks/lightning.tscn")
# AttackNodes
@onready var bubble_timer = get_node("%BubbleTimer")
@onready var bubble_attack_timer = get_node("%BubbleAttackTimer")
@onready var lightning_timer = get_node("%LightningTimer")
@onready var lightning_attack_timer = get_node("%LightningAttackTimer")
@onready var urchin_timer = get_node("%UrchinTimer")
@onready var urchin_attack_timer = get_node("%UrchinAttackTimer")



# Upgrades
var collected_upgrades = [] # upgrades player has
var upgrade_options = [] # currently offered upgrades
var health = 100.0
var max_health = 100.0
var speed = 150.0
var armor = 0
var attack_size = 0
var attack_cooldown = 0
var additional_attacks = 0 # duplicator

# Bubble
var bubble_ammo = 0
var bubble_baseammo = 0
var bubble_attackspeed = 1.5
var bubble_level = 0 # TODO: change back to 0

# Lightning
var lightning_ammo = 0
var lightning_baseammo = 0
var lightning_attackspeed = 2
var lightning_level = 0

# Urchin
var urchin_ammo = 0
var urchin_baseammo = 0
var urchin_attackspeed = 1.5
var urchin_level = 0 # TODO: change back to 0

# Enemy Related (track closest enemy)
var enemy_close = []

func _ready():
	upgrade_character("urchin1")
	attack()
	print(str(collected_upgrades))

func attack():
	if bubble_level > 0:
		bubble_timer.wait_time = bubble_attackspeed * (1-attack_cooldown)
		if bubble_timer.is_stopped():
			bubble_timer.start()
	if lightning_level > 0:
		lightning_timer.wait_time = lightning_attackspeed * (1-attack_cooldown)
		if lightning_timer.is_stopped():
			lightning_timer.start()
	if urchin_level > 0:
		urchin_timer.wait_time = urchin_attackspeed * (1-attack_cooldown)
		if urchin_timer.is_stopped():
			urchin_timer.start()




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
	

# TODO: play sound on taking damage
func _on_hurt_box_hurt(damage, _angle, _knockback):
	health -= clamp(damage-armor, 1.0, 999.0)
	# flash red on hit
	animated_sprite.modulate = Color(1,0,0,1)
	flash_on_hit_timer.start()

func _on_urchin_timer_timeout():
	urchin_ammo += urchin_baseammo + additional_attacks
	urchin_attack_timer.start()

func _on_urchin_attack_timer_timeout():
	# shoot ammo
	print("urchin base ammo "+ str(urchin_baseammo))
	if urchin_ammo > 0:
		var urchin_attack = urchin.instantiate()
		urchin_attack.position = position
		urchin_attack.target = get_closest_target()
		urchin_attack.level = urchin_level
		add_child(urchin_attack)
		urchin_ammo -= 1
		if urchin_ammo > 0:
			urchin_attack_timer.start()
		else:
			urchin_attack_timer.stop()

func _on_lightning_timer_timeout():
	# load ammo
	lightning_ammo += lightning_baseammo
	lightning_attack_timer.start()


func _on_lightning_attack_timer_timeout():
	# TODO: fix lightning spawn
	if lightning_ammo > 0:
		var lightning_attack = lightning.instantiate()
		lightning_attack.level = lightning_level
		lightning_attack.position = position
		lightning_attack.z_index = 10
		add_child(lightning_attack)
		move_child(lightning_attack, 0)
		lightning_ammo -= 1
		if lightning_ammo > 0:
			lightning_attack_timer.start()
		else:
			lightning_attack_timer.stop()

func _on_bubble_timer_timeout():
	# load ammo
	bubble_ammo += bubble_baseammo + additional_attacks
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

# return character to normal colour after flashing red on hit
func _on_flash_on_hit_timer_timeout():
	animated_sprite.modulate = Color(1,1,1,1)

		
# Experience and Level Functions
func gain_exp(amount):
	var required = exp_to_next_level()
	if level == 1:
		xp_bar.initialize(xp, required)
	var growth_data = []
	collected_exp += amount
	if xp + collected_exp >= required:
		collected_exp -= required - xp
		level += 1
		levelup()
		lvl_label.text = "LVL: " + str(level)
		growth_data.append([required, required])
		xp = 0
		
	else:
		xp += collected_exp
		collected_exp = 0
	growth_data.append([xp, required])
	xp_gained.emit(growth_data)
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


func levelup():
	print("level")
	snd_lvl_up.play()
	var tween = lvl_panel.create_tween()
	tween.tween_property(lvl_panel, "position", Vector2(440, 110), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	lvl_panel.visible = true
	
	var options = 0
	var options_max = 3
	while options < options_max:
		print("OPTIONS: " + str(options) + " max: " + str(options_max))
		var option_choice = item_options.instantiate()
		option_choice.item = get_random_item()
		upg_options.add_child(option_choice)
		options += 1
	
	get_tree().paused = true

func upgrade_character(upgrade):
	match upgrade:
		"bubble1":
			bubble_level = 1
			bubble_baseammo += 1
		"bubble2":
			bubble_level = 2
			bubble_baseammo += 1
		"bubble3":
			bubble_level = 3
		"bubble4":
			bubble_level = 4
			bubble_baseammo += 2
		"urchin1":
			urchin_level = 1
			urchin_baseammo += 1
		"urchin2":
			urchin_level = 2
			urchin_baseammo += 1
		"urchin3":
			urchin_level = 3
		"urchin4":
			urchin_level = 4
			urchin_baseammo += 2
		"lightning1":
			lightning_level = 1
			lightning_baseammo += 1
		"lightning2":
			lightning_level = 2
			lightning_baseammo += 1
		"lightning3":
			lightning_level = 3
			lightning_attackspeed -= 0.5
		"lightning4":
			lightning_level = 4
			lightning_baseammo += 1
		"armor1","armor2","armor3","armor4":
			armor += 1
		"speed1","speed2","speed3","speed4":
			speed += 50.0
		"tome1","tome2","tome3","tome4":
			attack_size += 0.10
		"scroll1","scroll2","scroll3","scroll4":
			attack_cooldown += 0.05
		"ring1","ring2":
			additional_attacks += 1
		"heal":
			health += 20
			health = clamp(health,0,max_health)
	
	var option_children = upg_options.get_children()
	for option in option_children:
		option.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	lvl_panel.visible = false
	lvl_panel.position.x = 1300
	# TODO: remove print
	print(str(collected_upgrades))
	attack()
	get_tree().paused = false
	gain_exp(0)

func get_random_item():
	var db_list = []
	for item in UpgradeDb.UPGRADES:
		if item in collected_upgrades: # if we already have upgrade
			pass
		elif item in upgrade_options: # if item already an option (avoid dupes)
			pass
		elif UpgradeDb.UPGRADES[item]["type"] == "item": # skip heal (unless last)
			pass
		elif UpgradeDb.UPGRADES[item]["prereq"].size() > 0: # check prereqs
			for req in UpgradeDb.UPGRADES[item]["prereq"]:
				if not req in collected_upgrades:
					pass
				else:
					db_list.append(item)
		else:
			db_list.append(item)
	if db_list.size() > 0:
		var random_item = db_list.pick_random()
		upgrade_options.append(random_item)
		return random_item
	else:
		return null


