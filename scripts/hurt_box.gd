extends Area2D


@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0
@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer

signal hurt(damage) 

func _on_area_entered(area):
	print("area entered")
	if area.is_in_group("attack"):
		print("hit1")
		if not area.get("damage") == null:
			match HurtBoxType:
				0: #cooldown
					#collision.call_deferred("set", "disabled", true)
					disable_timer.start()
				1: #hitonce
					pass
				2: #Disable hitbox
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage = area.damage
			emit_signal("hurt", damage)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)
					


func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
