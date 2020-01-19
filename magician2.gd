extends KinematicBody2D

var SPEED = 250
var GRAVITY = 150
const FLOOR = Vector2(0, -1)
#const JUMP_FORCE = -400

var velocity = Vector2()
var jump_trigger = false
var stop = false
var dragonShield = false


#func normalization(xvar):
	#velocity.x = xvar
	#return velocity

#func jump():
	#jump_trigger = true
	#velocity.y = JUMP_FORCE
	#$Timer.start()
	#$AnimatedSprite.play("jump")
	
func _physics_process(delta):

	if jump_trigger == false:
		velocity.y = GRAVITY
		velocity.x = SPEED
		$AnimatedSprite.play("run")
	
	#if $RayCast2D.is_colliding() == false && is_on_floor() && onEchafaudage == false:
		#jump()
	#if $impactmur.is_colliding() == true && is_on_floor() && onEchafaudage == true && isChanged == false:
		#SPEED = -250
		#$AnimatedSprite.set_flip_h(true)
	#if $impactmurgauche.is_colliding() == true && is_on_floor() && onEchafaudage == true && isChanged == false:
		#SPEED = 250
		#$AnimatedSprite.set_flip_h(false)	
	#if stop == false && position.x >= $checker.position.x  && position.x <= $"../checker2".position.x :
			#move_and_slide(velocity/2 , FLOOR)	
	#if is_on_floor() == false && velocity.y > 0:
		#$AnimatedSprite.play("fall")
		#pass
	if stop == false:
		move_and_slide(velocity, FLOOR)
	
#func _on_Timer_timeout():
	#velocity.y = 300
	#$Timer.stop()
	#jump_trigger = false

func _on_TouchScreenButton_released():
	if $ProgressBar/CD.time_left == 0:
		dragonShield = true
		$AudioStreamPlayer2D.stream = load("res://sounds/18537.wav")
		$AudioStreamPlayer2D.play(0)
		$shieldtimer.start()
		$ProgressBar/CD.start()
	
		

func _on_shieldtimer_timeout():
	dragonShield = false
