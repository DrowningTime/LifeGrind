extends Node2D

var player_data = {}
var area_mapping = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_size = get_viewport_rect().size
	_determine_layout(viewport_size)
	_welcome_message()
	_draw_areas()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _welcome_message():
	#var greeting_box = $GreetingMessageBox
	#greeting_box.position.x = 0
	#greeting_box.position.y = 0
	$GreetingMessageBox/GreetingMessageText.text = "Hello, " + str(player_data.user.username)
	#$Area0.position.x = viewport_size.x/2 
	#$Area0.position.y = viewport_size.y/2 

func _draw_areas():
	for area in player_data.user.areas:
		var area_scene = preload("res://Area/Area.tscn")
		var area_node = area_scene.instantiate()
		area_node.name = str(area.id)
		area_node.area_data = area
		var test = area_node.get_child(0)
		print(str(test.size.x))
		#area_node.global_position.x = area_mapping[str(area.id)].x - area_node.rect_size / 2
		area_node.global_position.y = area_mapping[str(area.id)].y
		add_child(area_node)

func _determine_layout(viewport_size):
	area_mapping = {"1": {"x": viewport_size.x/2, "y": viewport_size.y/2 }, 
	"2": {"x": viewport_size.x/2, "y": 50 }}
	return area_mapping
