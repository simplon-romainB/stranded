extends Area2D

var pressed = false
var game_over = false


func _on_TouchScreenButton_pressed():
	pressed = true
	$Area2D/mushrooms.position.y = 350

func _on_TouchScreenButton_released():
	pressed = false # Replace with function body.
	$Area2D/mushrooms.position.y = 150

func _on_Area2D_body_entered(body):
	if "player" in body.name && pressed == false:
		game_over = true
