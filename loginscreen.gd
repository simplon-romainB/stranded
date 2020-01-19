extends Control




func _on_loginbutton_pressed():
	get_tree().change_scene("res://logingame.tscn")


func _on_registerbutton_pressed():
	get_tree().change_scene("res://registergame.tscn")
