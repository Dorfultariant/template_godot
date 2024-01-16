extends CharacterBody2D

signal ap_shot(pos, direction)
signal he_shot(pos, direction)
signal hmg_shot(pos, direction)

var is_main_loaded: bool = true
var is_secondary_loaded: bool = true
var secondaryborn = 0

var SPEED = 300.0
const ROTATIONSPEED = 0.7

var MAX_SPEED = 600
const MAX_REVERSE_SPEED = -200

var movement_direction = 1
var ammoType: bool = true
var fasterMovement: bool = false
var accumulatedSpeed = 0

# Created this comment to test git push via commandline
func _physics_process(delta):
	# Add the gravity.
	velocity = Vector2.ZERO
	var turretDirection = (get_global_mouse_position() - $Turret.global_position).normalized()
	secondaryborn += delta
	if secondaryborn > 0.25:
		is_secondary_loaded = true
	#$Hull/Turret.look_at(get_global_mouse_position())
	#$Hull/Turret.rotation += PI/2
	
	## Toggle faster movement
	if Input.is_action_just_pressed("SPRINT"):
		fasterMovement = !fasterMovement
	if fasterMovement:
		SPEED = 600
	else:
		SPEED = 300
	movement_direction = 1
	if Input.is_action_pressed("UP") and accumulatedSpeed < MAX_SPEED:
		accumulatedSpeed += SPEED * delta
		movement_direction = 1
	elif Input.is_action_pressed("DOWN") and accumulatedSpeed > MAX_REVERSE_SPEED:
		accumulatedSpeed -= SPEED * delta
		movement_direction = -1
	elif accumulatedSpeed > 0:
		accumulatedSpeed -= SPEED * delta
		
	if Input.is_action_pressed("LEFT"):
		rotation = rotation - movement_direction * ROTATIONSPEED * delta
	if Input.is_action_pressed("RIGHT"):
		rotation = rotation + movement_direction * ROTATIONSPEED * delta
	if Input.is_action_pressed("PRIMARY"):
		ammoType = true
		print(ammoType)
	if Input.is_action_pressed("SECONDARY"):
		ammoType = false
		print(ammoType)
	# Handles the main gun shooting signal and reload timer
	if Input.is_action_just_pressed("LMB") and is_main_loaded:
		is_main_loaded = false
		if ammoType:
			ap_shot.emit($Turret/MainAmmoPoint.global_position, turretDirection)
		else:
			he_shot.emit($Turret/MainAmmoPoint.global_position, turretDirection)
		$MainGunReloadTimer.start()
		
	if Input.is_action_pressed("RMB") and is_secondary_loaded:
		secondaryborn = 0
		is_secondary_loaded = false
		hmg_shot.emit($Turret/SecondaryAmmoPoint.global_position, turretDirection)
		#$SecondaryGunReloadTimer.start()
		
	
	velocity = Vector2(1, 0).rotated(rotation) * accumulatedSpeed
	move_and_slide()


func collision():
	velocity = Vector2.ZERO

func _on_main_gun_reload_timer_timeout():
	is_main_loaded = true

func _on_secondary_gun_reload_timer_timeout():
	is_secondary_loaded = true
