extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_scene = preload("res://Player/Player.tscn")
	var player = player_scene.instantiate()
	player.build_player_data()
	add_child(player)
	var greeting_message_box = get_node("/root/World/Player/Map/GreetingMessageBox/GreetingMessageText")
	greeting_message_box.text = ("Hello " + str($Player.player_data.user.username))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
