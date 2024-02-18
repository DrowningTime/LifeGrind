extends Node

var player_data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func build_player_data():
	player_data = APIAgent.player_data
	var map_scene = preload("res://Map/Map.tscn")
	var map = map_scene.instantiate()
	add_child(map)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
