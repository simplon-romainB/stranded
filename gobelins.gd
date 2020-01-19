extends Area2D

func _ready():
	randomize()

var xtranslate = randi() % 8
var ytranslate = 5
var plongeursAxe = Vector2(xtranslate,ytranslate)


func _physics_process(delta):
	translate(plongeursAxe)
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	

	
