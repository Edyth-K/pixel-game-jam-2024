extends Area2D

var offset = randf_range(-0.2,0.2) # adds spray effect to the bubble
var speed = 250 # initial bubble speed
var travel_distance = 0 # destroy bubble after it's travelled enough

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	const RANGE = 150
	# bubble decelerates 
	if speed > 0:
		speed -= speed*0.05
	
	# bubble shoots towards enemy but with random offset for spray effect
	var direction = Vector2.RIGHT.rotated(rotation+offset)
	position += direction * speed * delta
	travel_distance += speed * delta
	# despawn bubble when it slows down enough or if it travels far enough
	if travel_distance > RANGE or speed <= 5:
		queue_free()

func _on_body_entered(body):
	queue_free() # destroy bullet when it collides
	if body.has_method("take_damage"):
		body.take_damage(5)
