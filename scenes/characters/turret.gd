extends CharacterBody2D

signal ap(pos, direction)
signal he(pos, direction)

#const ap_scene: PackedScene = preload("res://scenes/projectiles/ap.tscn")

const SPEED = 300.0
var direction

func _physics_process(delta):
	#direction = (get_global_mouse_position() - position).normalized()
	look_at(get_global_mouse_position())
	direction = (get_global_mouse_position() - position).normalized()
	
