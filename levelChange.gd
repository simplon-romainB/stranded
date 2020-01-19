extends Control

func _ready():
	firebase.save_document("newrecords?documentId=%s" % firebase.user_info.id,firebase.profile, $HTTPRequest5)
	pass

	
func _on_HTTPRequest5_request_completed(result, response_code, headers, body):
	var result_body = JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code == 409:
		firebase.get_document("newrecords/%s" % firebase.user_info.id, $HTTPRequest6)
		var result_array = yield($HTTPRequest6, "request_completed") as Array
		var result_time = JSON.parse(result_array[3].get_string_from_ascii()).result as Dictionary
		if String(result_time.fields.time).to_int() < String(firebase.profile.time).to_int():
			return
		if String(result_time.fields.time).to_int()>= String(firebase.profile.time).to_int():
			firebase.update_document("newrecords/%s" % firebase.user_info.id,firebase.profile, $HTTPRequest6)
	



func _on_HTTPRequest7_request_completed(result, response_code, headers, body):
	$bgload.load_scene("res://background.tscn")


func _on_displayranking2_pressed():
	firebase.profile.userName = { "stringValue":$displayranking2/LineEdit.text}
	firebase.save_document("newrecords?documentId=%s" % firebase.user_info.id,firebase.profile, $HTTPRequest5)
	firebase.get_document("newrecords/", $HTTPRequest8)
	


func _on_HTTPRequest8_request_completed(result, response_code, headers, body):
	var result_body = JSON.parse(body.get_string_from_ascii()).result as Dictionary
	var result_body_array = []
	for i in result_body.documents:
		result_body_array.append([String(i.fields.time).replace("integerValue:","").replace("{","").replace("}","").to_int() , String(i.fields.userName).replace("stringValue:",""),String(i.name)])
		#var newlabel = Label.new()
		#$ScrollContainer/VBoxContainer.add_child(newlabel)
		#newlabel.text = String(i.fields.email).replace("stringValue:","") + " " + String(i.fields.time).replace("integerValue:","")
	result_body_array.sort_custom(self, "sort")
	for i in result_body_array:
		var newlabel = Label.new()
		$ScrollContainer2/VBoxContainer.add_child(newlabel)
		newlabel.text = String(i[1]) + " " + String(i[0]/60000) + "min" + String(i[0]/1000) + "sec" + String(i[0]%1000) +"ms"
	print("you are " + String(result_body_array.bsearch("projects/strandedtest/databases/(default)/documents/newrecords/" + String(firebase.user_info.id))+1) + "/" +String(result_body_array.size()))
func sort(a, b):
    if a[0] < b[0]:
       return true
    return false
