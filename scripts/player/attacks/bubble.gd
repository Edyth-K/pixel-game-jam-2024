extends Area2D

var level = 1
var hp = 1 # hp of projectile; how many enemies 1 projectile can hit
var speed = 100
var damage = 5
var knock_amount = 100
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

var offset = randf_range(-0.2,0.2) # adds spray effect to the bubble

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			hp = 1
			speed = 100
			damage = 5
			knock_amount = 100
			attack_size = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += angle * speed * delta
	"""
	const RANGE = 150
	# bubble decelerates 
	if speed > 0:
		speed -= speed*0.05
	
	# bubble shoots towards enemy but with random offset for spray effect
	var direction = Vector2.RIGHT.rotated(rotation+offset)
	position += direction * speed * delta

	# despawn bubble when it slows down enough or if it travels far enough
	if speed <= 5:
		queue_free()
	"""
func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		queue_free()

func _on_body_entered(body):
	queue_free() # destroy bullet when it collides
	if body.has_method("take_damage"):
		body.take_damage(5)

func _on_timer_timeout():
	queue_free()
