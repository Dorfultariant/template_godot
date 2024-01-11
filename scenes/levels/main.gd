extends Node2D

var armor_piercing_scene: PackedScene = preload("res://scenes/projectiles/armor_piercing.tscn")
var heavy_explosive_scene: PackedScene = preload("res://scenes/projectiles/heavy_explosive.tscn")
# Called when the node enters the scene
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_tank_ap_shot(pos, direction):
	var ap = armor_piercing_scene.instantiate()
	
	ap.position = pos
	ap.rotation = $Tank/Turret.rotation
	ap.direction = direction
	$Projectiles.add_child(ap)


func _on_tank_he_shot(pos, direction):
	var he = heavy_explosive_scene.instantiate()
	
	he.position = pos
	he.rotation = $Tank/Hull/Turret.rotation
	he.direction = direction
	$Projectiles.add_child(he)
