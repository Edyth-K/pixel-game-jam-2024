extends CharacterBody2D
@onready var player = get_node("/root/Game/Player")
@onready var animated_sprite = $AnimatedSprite2D
@onready var label = $Label
@onready var hit_box = $HitBox

# modifier for stats (to create random enemies of same type)
# make mod = 1 for no change
# var mod = 1
var mod = randf_range(1, 1.5)
@export var speed = 35 * mod
@export var health = int(15)
@export var enemy_damage = 1

@export var knockback_recovery = 3.5
@export var knockback = Vector2.ZERO
@onready var snd_hit = $snd_hit
var exp_reward = int(15 * mod)# amount of exp awarded on kill
#var exp_reward = 100# amount of exp awarded on kill
signal remove_from_array(object)

func _ready():
	scale.x *= mod
	scale.y *= mod
	hit_box.damage = enemy_damage
	
# _physics_process essentially called every frame
func _physics_process(_delta):
	
	# for debugging, health display
	label.text = str(health)
	
	# knockback calculation
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	
	# move towards player
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	velocity += knockback
	move_and_slide()
	
	if direction.x > 0:
		animated_sprite.flip_h = true
	elif direction.x < 1:
		animated_sprite.flip_h = false

# TODO: sometimes sound doesn't play? 
# maybe need to make a new sound player on hit

func _on_hurt_box_hurt(damage, angle, knockback_amount):

	health -= damage
	# TODO: figure out how to turn this into signals instead
	get_parent().get_parent().dmg_text(damage, position)
	knockback = angle * knockback_amount
	snd_hit.play()
	if health <= 0:
		emit_signal("remove_from_array", self)
		player.gain_exp(exp_reward)
		print("Gained " + str(exp_reward) + " exp")
		queue_free()


