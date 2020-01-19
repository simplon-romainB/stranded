extends Control

var httpclient = HTTPClient.new()

var init_save = { "checkpoint": {} }

func _ready():
	httpclient.set_blocking_mode(true)
	init_save.checkpoint = {"integerValue": 0}


func _on_Button_pressed():
	firebase.login($playernamelabel/LineEdit.text, $passwordlabel/LineEdit.text, $HTTPRequest )	


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var result_body = JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code == 400:
		var announce = Label.new()
		get_parent().add_child(announce)
		announce.text = "email or password invalid"
		yield(get_tree().create_timer(2.0), "timeout")
		get_parent().remove_child(announce)
	else:
		yield(get_tree().create_timer(2.0),"timeout")
		firebase.get_document("saves/%s" % firebase.user_info.id, $HTTPRequest2)

func _on_HTTPRequest2_request_completed(result, response_code, headers, body):
	var result_body = JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code == 200:
		firebase.init_save.checkpoint = {"integerValue": result_body.fields.checkpoint}
	firebase.save_document("saves?documentId=%s" % firebase.user_info.id,init_save, $HTTPRequest3)

func _on_HTTPRequest3_request_completed(result, response_code, headers, body):
	get_tree().change_scene("res://main.tscn")
