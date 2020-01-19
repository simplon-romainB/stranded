extends Node2D

var tree = false


#func _physics_process(delta):
	#if tree == true && rotation_degrees > -90:
		#$StaticBody2D/CollisionShape2D.set_disabled(false)
		#rotation_degrees = rotation_degrees - 10



	


func _on_TouchScreenButton_released():
	$Tween.interpolate_property(self,"rotation_degrees",0,-90,0.5,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Tween.interpolate_property(self, "rotation_degrees",-90,-80,0.1,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Tween.interpolate_property(self, "rotation_degrees",-80,-90,0.1,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	$Tween.start()
#func _shake():
	#$Tween3.interpolate_property(self,"rotation_degrees",-90,-93,0.5,Tween.TRANS_BOUNCE,Tween.EASE_IN)
	#$Tween3.start()
	

func _on_Tween_tween_completed(object, key):
	#$Tween2.interpolate_property(self,"rotation_degrees",-90,-91,0.5,Tween.TRANS_BOUNCE,Tween.EASE_IN)
	#$Tween2.start()
	pass
