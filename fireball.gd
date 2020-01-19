extends Area2D

const SPEED = 200
var velocity = Vector2(-50,25)


func _ready():
	pass 
	
func _physics_process(delta):
	translate(velocity)




func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_fireball_body_entered(body):
	if "player" in body.name:
		body.stop = true
		print(body.stop)
