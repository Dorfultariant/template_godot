extends CharacterBody2D

signal ap(pos, direction)
signal he(pos, direction)


const SPEED = 300.0
const ROTATIONSPEED = 0.7
var movement_direction = 1
var is_loaded: bool = true
# Created this comment to test git push via commandline
func _physics_process(delta):
	# Add the gravity.
	velocity = Vector2.ZERO
	var turretDirection = (get_global_mouse_position() - position).normalized()
	$Hull/Turret.look_at(get_global_mouse_position())
	#$Hull/Turret.rotation += PI/2
	movement_direction = 1
	if Input.is_action_pressed("UP"):
		velocity = Vector2(1, 0).rotated(rotation) * SPEED
		movement_direction = 1
	if Input.is_action_pressed("DOWN"):
		velocity = Vector2(-1, 0).rotated(rotation) * SPEED
		movement_direction = -1
	if Input.is_action_pressed("LEFT"):
		rotation = rotation - movement_direction * ROTATIONSPEED * delta
	if Input.is_action_pressed("RIGHT"):
		rotation = rotation + movement_direction * ROTATIONSPEED * delta
	# Handles the main gun shooting signal and reload timer
	if Input.is_action_just_pressed("PRIMARY") and is_loaded:
		is_loaded = false
		ap.emit($Hull/Turret/ProjectilePoint.global_position, turretDirection)
		$MainReloadTimer.start()
		
	move_and_slide()



func _on_main_reload_timer_timeout():
	is_loaded = true
