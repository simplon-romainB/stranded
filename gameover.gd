extends Node2D







func _on_Button_pressed():
	$Button.hide()
	$Label.hide()
	$retryall.hide()
	$bgload.load_scene("res://background.tscn")
	
	


func _on_retryall_pressed():
	$Button.hide()
	$Label.hide()
	$retryall.hide()
	firebase.init_save.checkpoint = {"integerValue": 0}
	firebase.update_document("saves/%s" % firebase.user_info.id,firebase.init_save, $HTTPRequest3)
	$bgload.load_scene("res://background.tscn")
	#var save_dict = {
		#loading = 0
	#}
	#$retryall.hide()
	#var save_file = File.new()
	#save_file.open("res://save.json", File.WRITE)
	#save_file.store_line(to_json(save_dict))
	#save_file.close()
	
