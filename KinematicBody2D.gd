extends KinematicBody2D

const SPEED = 250
const GRAVITY = 150
const FLOOR = Vector2(0, -1)
const VERTICAL_SPEED = -20

var isDragon = true




var velocity = Vector2()
var game_over = false

func _physics_process(delta):
	if isDragon == true:
		velocity.x = SPEED
		move_and_slide(velocity)
	if isDragon == false && position.x < 8500:
		velocity.x = SPEED
		move_and_slide(velocity)
	if isDragon == false && position.x > 8500:
		velocity.x = 60
		velocity.y = VERTICAL_SPEED
		move_and_slide(velocity)
	if isDragon == false && position.x >= 14600:
		velocity.x = SPEED
		velocity.y = 0
		move_and_slide(velocity)
		#$AnimatedSprite.translate(Vector2(0,-50))
	if isDragon == false && position.x >= 15680:
		velocity.x = 100
		velocity.y = VERTICAL_SPEED
		move_and_slide(velocity)

func dragonDisapear():
	$Tween.interpolate_property($AnimatedSprite, "position", Vector2($AnimatedSprite.position.x,$AnimatedSprite.position.y),Vector2($AnimatedSprite.position.x, $AnimatedSprite.position.y - 1000), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

