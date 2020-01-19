extends Node

var httpclient = HTTPClient.new()

const API_KEY ="AIzaSyBIMj3Ipx4x2cgYJyh28wompmgfbY9S1eE"
const PROJECT_ID = "strandedtest"
const REGISTER_URL ="https://radiant-temple-01565.herokuapp.com/users" 
const LOGIN_URL = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDyeRgkhWY6NXb2dEHpTmDv6JuDmYi8igs" 
const FIRESTORE_URL = "https://firestore.googleapis.com/v1/projects/strandedtest/databases/(default)/documents/"
const FIRESTORE_SORTING = "http://localhost:5001/strandedtest/us-central1/sorting"
var user_info = {}
var profile = {}
var init_save = { "checkpoint": {} }

#http://localhost:5001/strandedtest/us-central1/sorting
#https://us-central1-strandedtest.cloudfunctions.net/sorting


func _get_user_info(result):
	#var result_body = JSON.parse(get_string_from_ascii()).result[2] as Dictionary
	print(result)
	return {
		"token":result.idToken,
		"id":result.localId,
		"body":result
		}
func _get_request_headers():
	return([
		"content-Type: application/json",
		#"authorization: Bearer %s" % user_info.token
		]) 
	
func register(name,mail,password,http):
	var body = {
		"name":name,
		"email":mail,
		"password":password
		}
	var jbody = JSON.print(body)
	print(jbody)
	print(typeof(jbody))
	http.request(REGISTER_URL, _get_request_headers(), false, HTTPClient.METHOD_POST, jbody)
	var result = yield(http, "request_completed") as Array
	if result[1] == 200:
		user_info = _get_user_info(result)
	
	
func login(mail,password,http):
	var body = {
		"email":mail,
		"password":password,
		"returnSecureToken": true
		}	
	http.request(LOGIN_URL, [], false, HTTPClient.METHOD_POST, to_json(body))
	var result = yield(http, "request_completed") as Array
	if result[1] == 200:
		user_info = _get_user_info(result)
		
	
	
	

func save_document(path,fields,http):
	var document = { "fields": fields}
	var body = to_json(document)
	var url = FIRESTORE_URL + path
	http.request(url,_get_request_headers(), false, HTTPClient.METHOD_POST, body)
	#httpclient.request( HTTPClient.METHOD_POST, url, _get_request_headers(), body)

	
func get_document(path,http):
	var url = FIRESTORE_URL + path
	http.request(url,_get_request_headers(), false, HTTPClient.METHOD_GET)

func update_document(path,fields,http):
	var document = { "fields": fields}
	var body = to_json(document)
	var url = FIRESTORE_URL + path
	http.request(url,_get_request_headers(), false, HTTPClient.METHOD_PATCH, body)
	
func sorting(http):
	var url = FIRESTORE_SORTING
	http.request(url, _get_request_headers(), false, HTTPClient.METHOD_GET)
	
func hello(http):
	http.request("https://us-central1-strandedtest.cloudfunctions.net/helloWorld", _get_request_headers(), false, HTTPClient.METHOD_GET)
	

