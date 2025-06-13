extends Node

#loaded account data state objct
var player_data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
#Fetch player data and preload map scene based off of it
#add map object as child player
func build_player_data():
	player_data = APIAgent.player_data
	var map_scene = preload("res://Map/Map.tscn")
	var map = map_scene.instantiate()
	map.player_data = player_data
	add_child(map)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
