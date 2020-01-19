extends KinematicBody2D


var SPEED = 250
var GRAVITY = 150
const FLOOR = Vector2(0, -1)
const JUMP_FORCE = -450

var velocity = Vector2()
var jump_trigger = false
var stop = false
var onEchafaudage = false
var isChanged = false

func normalization(xvar):
	velocity.x = xvar
	return velocity

func jump():
	jump_trigger = true
	velocity.y = JUMP_FORCE
	$Timer.start()
	#$AnimatedSprite.play("jump")
	
func _physics_process(delta):
	if jump_trigger == false && is_on_floor():
		velocity.y = GRAVITY
		velocity.x = SPEED
		$AnimatedSprite.play("run")
	
	if $RayCast2D.is_colliding() == false && is_on_floor() && onEchafaudage == false:
		jump()
	if $impactmur.is_colliding() == true && is_on_floor() && onEchafaudage == true && isChanged == false:
		SPEED = -250
		$AnimatedSprite.set_flip_h(true)
	if $impactmurgauche.is_colliding() == true && is_on_floor() && onEchafaudage == true && isChanged == false:
		SPEED = 250
		$AnimatedSprite.set_flip_h(false)	
	if is_on_floor() == false && velocity.y > 0:
		#$AnimatedSprite.play("fall")
		pass
		
	if stop == false:
		move_and_slide(velocity, FLOOR)
	
func _on_Timer_timeout():
	velocity.y = 300
	$Timer.stop()
	jump_trigger = false