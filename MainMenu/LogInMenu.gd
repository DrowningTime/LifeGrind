extends Control

const API = "https://life-grind-be.onrender.com/api/v1"

var email = "test01@email.com"
var password = "1234"
var username = "username"
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
	
func _on_reg_email_box_text_changed():
	email = $RegisterContainer/EmailBox.text

func _on_reg_password_box_text_changed():
	password = $RegisterContainer/PasswordBox.text
	
func _on_reg_username_box_text_changed():
	password = $RegisterContainer/UsernameBox.text

func _on_register_button_pressed():
	var data = {"user" : {"email": email,"password": password, "username": username}}
	$APIAgent.signIn(data)
