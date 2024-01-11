extends Node2D

var armor_piercing_scene: PackedScene = preload("res://scenes/projectiles/ap.tscn")
var heavy_explosive_scene: PackedScene = preload("res://scenes/projectiles/he.tscn")
var hmg_scene: PackedScene = preload("res://scenes/projectiles/hmg.tscn")


# Called when the node enters the scene
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_tank_ap_shot(pos, direction):
	var ap = armor_piercing_scene.instantiate()
	
	ap.position = pos
	ap.rotation = $Tank/Turret.global_rotation
	ap.direction = direction
	$Projectiles.add_child(ap)


func _on_tank_he_shot(pos, direction):
	var he = heavy_explosive_scene.instantiate()
	
	he.position = pos
	he.rotation = $Tank/Turret.global_rotation
	he.direction = direction
	$Projectiles.add_child(he)


func _on_tank_hmg_shot(pos, direction):
	var hmg = hmg_scene.instantiate()
	
	hmg.position = pos
	hmg.rotation = $Tank/Turret.global_rotation
	hmg.direction = direction
	$Projectiles.add_child(hmg)
