extends Node2D

const FIREBALL = preload("res://fireball.tscn")
const PLONGEURS = preload("res://plongeurs.tscn")
const MAGICIAN = preload("res://magician.tscn")
const MAGICIAN2 = preload("res://magician2.tscn")
const MAGICIAN3 = preload("res://magician3.tscn")
const DRAGONFIRE = preload("res://dragonfire.tscn")
const PLONGEURS3 = preload("res://plongeurs3.tscn")
const PLONGEURS4 = preload("res://plongeurs4.tscn")
const MAGICIAN4 = preload("res://magician4.tscn")

var time_start = 0
var time_now = 0
var path = "bottom"
var cavaliersMove = false
var isDragon = true
var isDragonFire = false
var mojo = 0
var endLvl = false
signal fire
signal fire2
signal fire3
var magician2 = MAGICIAN2.instance()
var dragonfire = DRAGONFIRE.instance()
var magician = MAGICIAN.instance()
var magician3 = MAGICIAN3.instance()
var magician4 = MAGICIAN4.instance()
var profile = { 
	"email": {},
	"time": {},
	"userName":{}
	}
# check = 0
#var init_save = {"intValue": check}

func load_game():
	#var save_file = File.new()
	#save_file.open("res://save.json", File.READ)
	#var data = {}
	#data = parse_json(save_file.get_as_text())
	#if data != {}:
		#if data.loading == 1:
			#$dragon.position = Vector2(data.dragonPos.x, data.dragonPos.y)
			#$player.position = Vector2(data.playerPos.x, data.playerPos.y)
	if String(firebase.init_save.checkpoint).to_int() == 0:
		print("checkpoint0")
	if String(firebase.init_save.checkpoint).to_int() == 1:
		$dragon.position = Vector2($checkpoint.position.x-25,0)
		$player.position = Vector2($checkpoint.position.x,640)
		

func _ready():
	profile.email = { "stringValue":firebase.user_info.body.email}
	load_game()
	time_start = OS.get_ticks_msec()
	#firebase.save_document("saves?documentId=%sf" % firebase.user_info.id,init_save, $httpsave)
	#firebase.sorting($HTTPRequest)

	

func game_over():
	profile.time = { "integerValue": String(time_now - time_start)}
	firebase.profile = profile
	get_parent().remove_child(dragonfire)
	get_tree().change_scene("res://gameover.tscn")
	
	
func _physics_process(delta):
	time_now = OS.get_ticks_msec()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60000
	var seconds = int((elapsed % 60000) / 1000)
	var mseconds = elapsed % 1000
	var str_elapsed = "%02d : %02d : %02d" % [minutes, seconds, mseconds]
	$dragon/Panel/Label.text = str_elapsed
	#if isDragon == true:
		#if barrelHit == true:
			#$barrel.move_and_slide(Vector2(-300,150), $player.FLOOR)
	if cavaliersMove == true:
		$cavaliers.move_and_slide(Vector2(-200,0), $player.FLOOR)
	#if barrelDrop == true:
		#$barreldrop.move_and_slide(Vector2(0,400), $player.FLOOR)
	if magician.fire == true:
		emit_signal("fire")
	if magician3.fire2 == true:
		emit_signal("fire2")
	if magician4.fire3 == true:
		emit_signal("fire3")
	#if path == "top" && $player.position.y < $bridgenabler.position.y :
		#$echafaudage2/echafaudagecoll.set_disabled(false)
	#if path == "top" && $player.position.y <= $bridgenabler2.position.y :
		#$echafaudage3/echafaudagecoll.set_disabled(false)
	#if path == "top" && $player.position.y <= $bridgenabler3.position.y :
		#6+
		#$echafaudage8/echafaudagecoll.set_disabled(false)
func _on_Area2D2_body_entered(body):
	if "player" in body.name:
		game_over()

func _on_Timer_timeout():
	var fireball = FIREBALL.instance()
	get_parent().add_child(fireball)
	fireball.position = $tower.position

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	$Timer.start()

func _on_TouchScreenButton_released():
	$echafaudage/CollisionShape2D.set_disabled(false)
	path = "top"
	$plongeurstimer.start()
	get_parent().add_child(magician)
	get_parent().add_child(magician2)
	magician.position.y = $player.position.y
	magician.position.x = $player.position.x - 150
	magician2.position.y = $player.position.y
	magician2.position.x = $player.position.x - 300
	$dragonfiretimer.start()
	$magician3timer.start()
	$magician4timer.start()
	$dragon.isDragon = false
	$dragon.dragonDisapear()
	

	
func _on_tower_towerOff():
	$Timer.stop()
	$player.stop = false
	
func _on_army_body_entered(body):
	if "player" in body.name:
		game_over()
	if "barrel" in body.name:
		$barrel.queue_free()
		$army.queue_free()

func _on_barrelButton_pressed():
	$Tween2.interpolate_property($barrel, "position", Vector2($barrel.position.x,$barrel.position.y),Vector2($barrel.position.x,800), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween2.start()
	print("ok")
func _on_VisibilityNotifier2D_screen_entered():
	cavaliersMove = true

func _on_vavalierstouch_pressed():
	cavaliersMove = false
	$cavaliers.queue_free()

func _on_urukwood_body_entered(body):
	if "barrel" in body.name:
		$barreldrop.queue_free()
		$urukwood.queue_free()
	if "player" in body.name:
		game_over()

func _on_gyrotouch_pressed():
	$gyrocopter/Tween.interpolate_property($barreldrop, "position", Vector2($barreldrop.position.x,$barreldrop.position.y),Vector2($barreldrop.position.x,600), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$gyrocopter/Tween.start()

func _on_spambridge_released():
	$pontlevis.rotation_degrees = $pontlevis.rotation_degrees -10

func _on_plongeurstimer_timeout():
	var plongeurs = PLONGEURS.instance()
	plongeurs.position.x = $player.position.x
	plongeurs.position.y = $player.position.y - 500
	connect("fire", plongeurs, "queue_free")
	get_parent().add_child(plongeurs)
	
func _on_Visibility2D_screen_exited():
	if endLvl == false:
		game_over()
		pass



func _on_dragonfiretimer_timeout():
	get_parent().add_child(dragonfire)
	isDragonFire = true
	$dragontween.interpolate_property(dragonfire, "position", Vector2($player.position.x -1000, $player.position.y), Vector2($player.position.x - 500, $player.position.y), 1,Tween.TRANS_QUAD, Tween.EASE_OUT)
	$dragontween.start()
	$dragoncry.stream = load("res://sounds/16461.wav")
	$dragoncry.play(0)
	$dragonbreathtimer.start()


func _on_dragonbreathtimer_timeout():
	if magician2.dragonShield == false:
		print("fire")
		game_over()


func _on_magician3timer_timeout():
	get_parent().add_child(magician3)
	magician3.position.x = $player.position.x - 450
	magician3.position.y = $player.position.y
	$plongeurstimer3.start()
	


func _on_plongeurstimer3_timeout():
	var plongeurs3 = PLONGEURS3.instance()
	plongeurs3.position.x = $player.position.x
	plongeurs3.position.y = $player.position.y - 500
	connect("fire2", plongeurs3, "queue_free")
	get_parent().add_child(plongeurs3)


func _on_magician4timer_timeout():
	get_parent().add_child(magician4)
	magician4.position.x = $player.position.x - 450
	magician4.position.y = $player.position.y
	$plongeurs4timer.start()


func _on_plongeurs4timer_timeout():
	var plongeurs4 = PLONGEURS4.instance()
	plongeurs4.position.x = $player.position.x
	plongeurs4.position.y = $player.position.y - 500
	connect("fire3", plongeurs4, "queue_free")
	get_parent().add_child(plongeurs4)
	
func _on_checkpoint_body_entered(body):
	firebase.init_save.checkpoint = {"integerValue": 1}
	firebase.update_document("saves/%s" % firebase.user_info.id,firebase.init_save, $HTTPRequest)
	
	#var save_dict = {
		#loading = 1,
		#dragonPos = {
			#x=$dragon.position.x,
			#y=$dragon.position.y
			#}, 
		#playerPos = {
			#x=$player.position.x,
			#y=$player.position.y
			#}	
	#}
	#var save_file = File.new()
	#save_file.open("res://save.json", File.WRITE)
	#save_file.store_line(to_json(save_dict))
	#save_file.close()


func _on_Area2D_body_entered(body):
	if "player" in body.name && $wooden.catapult == false:
		game_over()


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var result_body = JSON.parse(body.get_string_from_ascii()).result 
	
	
	
	
		


func _on_httpsave_request_completed(result, response_code, headers, body):
	var result_body = JSON.parse(body.get_string_from_ascii()).result as Dictionary
	


func _on_hitbox_area_entered(area):
	 #if "gobelins" in area.name:game_over()
	pass
		


func _on_woodenNains_body_entered(body):
	if "player" in body.name && $woodenNains.lDwarf < 3 && $woodenNains.rDwarf < 3:
		game_over()


func _on_killermushs_body_entered(body):
	if $killermushs.game_over == true:
		game_over()


func _on_VisibilityNotifier2D_screen_exited():
	pass


func _on_arbremojotouch_pressed():
	if mojo >= 4:
		$sol/CollisionShape2D6.set_disabled(false)
	mojo = mojo +1	


func _on_cavaliersarea_body_entered(body):
	if "player" in body.name:
		game_over()


func _on_levelEnd_body_entered(body):
	endLvl = true
	profile.time = { "integerValue": String(time_now - time_start)}
	firebase.profile = profile
	get_tree().change_scene("res://levelChange.tscn")
	print("lvlchange")
