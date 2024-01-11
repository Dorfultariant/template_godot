extends CharacterBody2D

signal ap(pos, direction)
signal he(pos, direction)

var is_loaded: bool = true

const SPEED = 300.0
var direction

func _physics_process(delta):
	#direction = (get_global_mouse_position() - position).normalized()
	look_at(get_global_mouse_position())
	direction = (get_global_mouse_position() + position).normalized()
	
	if Input.is_action_just_pressed("PRIMARY") and is_loaded:
		is_loaded = false
		ap.emit($MainAmmoPoint.global_position, direction)
		$MainGunReloadTimer.start()
		

func _on_main_gun_reload_timer_timeout():
	is_loaded = true
