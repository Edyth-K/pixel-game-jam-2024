extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer
@onready var collision_shape_2d = $CollisionShape2D

@onready var player = get_tree().get_first_node_in_group("player")
var level = 1
var damage = 5
var attack_size = 1.0
# TODO: fix lightning script
var animation_played = false


signal remove_from_array(object)

func _ready():
	print(str(level))
	match level:
		1:
			damage = 5
			attack_size = 1.0
		2:
			damage = 10
			attack_size = 2.0
	scale.x *= attack_size
	scale.y *= attack_size
	timer.start()

func _physics_process(_delta):
	position = player.position
	
func _on_animated_sprite_2d_animation_finished():
	print("delete")
	queue_free()

func _on_timer_timeout():
	collision_shape_2d.set_deferred("disabled", false)
	animated_sprite_2d.play("shock")

func enemy_hit(_charge):
	pass
