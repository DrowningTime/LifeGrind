extends Control

const API = "https://life-grind-be.onrender.com/api/v1"

var email = "test01@email.com"
var password = "1234"
var http_request :  HTTPRequest

func _ready():
	pass

func _on_email_box_text_changed():
	email = $VBoxContainer/EmailBox.text

func _on_password_box_text_changed():
	password = $VBoxContainer/PasswordBox.text

func _on_log_in_button_pressed():
	var data = {"user" : {"email": email,"password": password}}
	$APIAgent.signIn(data)
