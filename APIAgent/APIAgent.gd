extends Node

const ENV = "DEV"
const API = "https://life-grind-be.onrender.com/api/v1"
const TESTDATA_PATH = r"M:\Godot Projects\TestData\TestData.json"

var player_data = {}
var http_request :  HTTPRequest
var response_body
var test_data
	
# Called when the node enters the scene tree for the first time.
func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed",Callable(self,"_on_request_completed"))
	test_data = _get_test_data()
	print(test_data)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Attempt to Login to backend and if successful, load the response text into var player_data
func signIn(data):
	var json
	var url = str(API + "/login")
	var headers = PackedStringArray(["Accept: application/json","Content-Type: application/json"])
	if ENV == "DEV":
		json = JSON.stringify(test_data)
		_on_request_completed(0, 200, headers, json)
	else: 
		json = JSON.stringify(data)
		http_request.request(url,headers,HTTPClient.METHOD_POST,json)

# Attempt to SignUp to backend and if successful, load the response text into var player_data
func signUp(data):
	var url = str(API + "/users")
	var headers = PackedStringArray(["Accept: application/json","Content-Type: application/json"])
	var json = JSON.stringify(data)
	http_request.request(url,headers,HTTPClient.METHOD_POST,json)


# Handle request errors and store response text into Node var for use
#USING TEST DATA!
func _on_request_completed(result, response_code, headers, body):
	if ENV == "DEV":
		APIAgent.player_data = test_data
		var scene_tree = get_tree()
		scene_tree.change_scene_to_file("res://World/World.tscn")
	elif result != 0:
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
		APIAgent.player_data = response_body
		var scene_tree = get_tree()
		scene_tree.change_scene_to_file("res://World/World.tscn")
		
func _get_test_data():
	var file = FileAccess.open(TESTDATA_PATH, FileAccess.READ)
	var content = {}
	while !file.eof_reached():
		content = JSON.parse_string(file.get_line())
	return content
			
func change_scene():
	var scene_tree = get_tree()
	scene_tree.change_scene_to_file("res://World/World.tscn")
				
