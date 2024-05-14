extends Area2D
@onready var disable_hit_box_timer = $DisableHitBoxTimer
@onready var collision_shape_2d = $CollisionShape2D

@export var damage = 1

func tempDisable():
	collision_shape_2d.call_deferred("set", "disabled", true)
	disable_hit_box_timer.start()

func _on_disable_hit_box_timer_timeout():
	collision_shape_2d.call_deferred("set", "disabled", false)
