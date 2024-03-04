extends Node2D

var player_data = {}
var area_mapping = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_size = get_viewport_rect().size
	_determine_layout(viewport_size)
	_welcome_message()
	_draw_areas()
	_draw_menus()

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
		area_node.name = str(area.position) + "_node"
		area_node.area_data = area
		area_node.connect("ready", func(): _on_area_node_ready(area_node))
		add_child(area_node)
		area_node.get_node(str(area.position) + "_menu_button").connect("pressed", func(): _display_area_menu(area_node.area_data))
		
func _draw_menus():
	var menu_scene = preload("res://UI/Area_Menu.tscn")
	var menu_node = menu_scene.instantiate()
	menu_node.name = "area_menu_node"
	menu_node.connect("ready", func(): _on_menu_node_ready(menu_node))
	add_child(menu_node)

func _determine_layout(viewport_size):
	area_mapping = {
	"0": {"x": viewport_size.x/2, "y": viewport_size.y/2 - 100}, 
	"1": {"x": viewport_size.x/2, "y": 50 },
	"2": {"x": viewport_size.x - 50, "y": viewport_size.y/3 -100 },
	"3": {"x": viewport_size.x - 50, "y": 2 * (viewport_size.y/3) -100 },
	"4": {"x": viewport_size.x/2, "y": viewport_size.y - 200 },
	"5": {"x": 50, "y": 2*(viewport_size.y/3)-100 },
	"6": {"x": 50, "y": viewport_size.y/3-100 },
	"Menu": {"x": viewport_size.x/2, "y": viewport_size.y/3}}
	return area_mapping
	
func _on_area_node_ready(area_node):
	var area_container_children = area_node.get_children()
	var area_container_label = area_container_children[0].get_child(0)
	var label_size = area_container_label.size
	area_node.global_position.x = area_mapping[str(area_node.area_data.position)].x - (label_size.x / 2)
	area_node.global_position.y = area_mapping[str(area_node.area_data.position)].y
	
func _on_menu_node_ready(menu_node):
	var area_menu = get_node(str(menu_node.name))
	print(get_node(str(area_menu.get_path()) + "/area_menu_background"))
	print(get_node(str(area_menu.get_path())+ "/area_menu_background").size)
	area_menu.global_position.x = area_mapping["Menu"].x - (get_node(str(area_menu.get_path()) + "/area_menu_background").size.x / 2)
	area_menu.global_position.y = area_mapping["Menu"].y

func _display_area_menu(area_data):
	var target_area = get_node("area_menu_node")
	await get_node("area_menu_node").update_menu(area_data)
	#if target_area.visible:
		#target_area.visible = false
	#else:
	target_area.visible = true
	print(area_data)
