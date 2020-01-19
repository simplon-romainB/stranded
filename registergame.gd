extends Node

const API_KEY ="AIzaSyBIMj3Ipx4x2cgYJyh28wompmgfbY9S1eE"
const REGISTER_URL ="https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBIMj3Ipx4x2cgYJyh28wompmgfbY9S1eE" 
const LOGIN_URL = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBIMj3Ipx4x2cgYJyh28wompmgfbY9S1eE" 

var current_token = ""

func _get_token_id_from_result(result):
	var result_body = JSON.parse(result[3].get_string_from_ascii()).result as Dictionary
	return result_body.idToken
	
func register(mail,password,http):
	var body = {
		"email":mail,
		"password":password,
		}
	http.request(REGISTER_URL, [], false, HTTPClient.METHOD_POST, to_json(body))
	var result = yield(http, "request_completed") as Array
	if result[1] == 200:
		current_token = _get_token_id_from_result(result)
	print(String(body))
	
func login(mail,password,http):
	var body = {
		"email":mail,
		"password":password 
		
		}	
	http.request(LOGIN_URL, [], false, HTTPClient.METHOD_POST, to_json(body))
	var result = yield(http, "request_completed") as Array
	if result[1] == 200:
		current_token = _get_token_id_from_result(result)
	print(String(body))



func _on_Button_pressed():
	var regex = RegEx.new()
	regex.compile("^(?=.*\\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[^\\w\\d\\s:])([^\\s]){8,16}$")
	var result = regex.search($passwordlabel/LineEdit3.text)
	if result && $passwordlabel/LineEdit3.text == $Label/LineEdit.text:
		firebase.register($namelabel/LineEdit.text,$maillabel/LineEdit2.text, $passwordlabel/LineEdit3.text, $HTTPRequest)
	elif result && $passwordlabel/LineEdit3.text != $Label/LineEdit.text:
		var announce = Label.new()
		get_parent().add_child(announce)
		announce.text = "password confirmation mismatch"
		yield(get_tree().create_timer(3.0), "timeout")
		get_parent().remove_child(announce)
	else:
		var announce = Label.new()
		get_parent().add_child(announce)
		announce.text = "password invalid"
		yield(get_tree().create_timer(3.0), "timeout")
		get_parent().remove_child(announce)
		
	#get_tree().change_scene("res://main.tscn")

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	get_tree().change_scene("res://logingame.tscn")
