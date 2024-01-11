extends Area2D
class_name Projectile

@export var speed: int = 2500
var direction: Vector2 = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	$SelfDestructTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	
	

# Handles the destruction of projectile after certain time
func _on_self_destruct_timer_timeout():
	queue_free()
