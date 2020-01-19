extends Sprite

var pillar_one = 0
var pillar_two = 0
var pillar_three = 0
var pillar_four = 0
signal towerOff

func disapear():
	if pillar_one == 1 || pillar_two == 1 || pillar_three == 1 || pillar_four == 1:
		emit_signal("towerOff")
		queue_free()


func _on_pillar1_pressed():
	pillar_one = 1
	disapear()


func _on_pillar2_pressed():
	pillar_two = 1
	disapear()


func _on_pillar3_pressed():
	pillar_three = 1
	disapear()


#func _on_pillar4_pressed():
	#pillar_four = 1
	#disapear()
