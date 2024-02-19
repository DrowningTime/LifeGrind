extends Node

const API = "https://life-grind-be.onrender.com/api/v1"

var player_data = {}
var http_request :  HTTPRequest
var response_body
	
# Called when the node enters the scene tree for the first time.
func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed",Callable(self,"_on_request_completed"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Attempt to Login to backend and if successful, load the response text into var player_data
func signIn(data):
	var url = str(API + "/login")
	var headers = PackedStringArray(["Accept: application/json","Content-Type: application/json"])
	var json = JSON.stringify(data)
	http_request.request(url,headers,HTTPClient.METHOD_POST,json)
	APIAgent.player_data = response_body
	var scene_tree = get_tree()
	scene_tree.change_scene_to_file("res://World/World.tscn")
	
func signUp(data):
	var url = str(API + "/users")
	var headers = PackedStringArray(["Accept: application/json","Content-Type: application/json"])
	var json = JSON.stringify(data)
	http_request.request(url,headers,HTTPClient.METHOD_POST,json)
	APIAgent.player_data = response_body
	var scene_tree = get_tree()
	scene_tree.change_scene_to_file("res://World/World.tscn")

# Handle request errors and store response text into Node var for use
func _on_request_completed(result, response_code, headers, body):
	if result != 0:
		print("HTTP request failed with error:", result)
	elif response_code != 200:
		print("HTTP request failed with response code:", response_code)
	else:
		print("result :" + str(result))
		print("response_code :" + str(response_code))
		print("headers :" + str(headers))
		print("body :" + body.get_string_from_utf8())
		var byte_array_as_string = body.get_string_from_utf8()
		APIAgent.response_body = JSON.parse_string(byte_array_as_string)
		
