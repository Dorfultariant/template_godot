extends CharacterBody2D

signal ap_shot(pos, direction)
signal he_shot(pos, direction)

const SPEED = 300.0
const ROTATIONSPEED = 0.7
var movement_direction = 1
# Created this comment to test git push via commandline
func _physics_process(delta):
	# Add the gravity.
	velocity = Vector2.ZERO
	var turretDirection = (get_global_mouse_position() - position).normalized()
	#$Hull/Turret.look_at(get_global_mouse_position())
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

	move_and_slide()




func _on_turret_ap(pos, direction):
	ap_shot.emit(pos, direction)


func _on_turret_he(pos, direction):
	he_shot.emit(pos, direction)
