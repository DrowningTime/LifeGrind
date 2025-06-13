extends Node2D

var player_data = {}
#{"user": { "id": 1, "username": "Jerk", "areas": [{"id": 2, "name": "DAY AREA", "position": 0, "streak": 0, "level": 0, "user_id": 1, "created_at": "2024-01-10T17:31:53.588Z", "updated_at": "2024-01-10T17:31:53.588Z", "subareas": [{ "id": 3, "name": "weight", "position": 1, "streak": 0, "level": 0, "user_id": 1, "created_at": "2024-01-10T17:31:53.689Z", "updated_at": "2024-01-10T17:31:53.689Z" }]}]}}
var area_mapping = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_size = get_viewport_rect().size
	_determine_layout(viewport_size)
	_draw_areas()
	_draw_menu()
	_hide_area_menu()
	get_node("area_menu_node").connect("close_area_menu_pressed",_hide_area_menu)

func _process(_delta):
	pass

func _draw_areas():
	for area in player_data.user.areas:
		var area_scene = preload("res://Area/Area.tscn")
		var area_node = area_scene.instantiate()
		area_node.name = str(area.position) + "_node"
		area_node.area_data = area
		area_node.connect("ready", func(): _on_area_node_ready(area_node))
		add_child(area_node)
		var area_button = area_node.get_node(str(area.position) + "_menu_button")
		area_button.connect("pressed", func(): _display_area_menu(area_button.get_meta("area_position")))
		
func _draw_menu():
	var menu_scene = preload("res://UI/Area_Menu.tscn")
	var menu_node = menu_scene.instantiate()
	menu_node.name = "area_menu_node"
	menu_node.global_position.x = area_mapping["Menu"].x
	menu_node.global_position.y = area_mapping["Menu"].y
	menu_node.SIZE_EXPAND_FILL
	#menu_node.connect("ready", func(): _on_menu_node_ready(menu_node))
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
	
func _display_area_menu(area_position):
	var display_area = get_node("area_menu_node")
	var area_data = player_data.user.areas[area_position]
	await get_node("area_menu_node").update_menu(area_data)
	display_area.visible = true
	
	
func _hide_area_menu():
	var display_area = get_node("area_menu_node")
	display_area.visible = false
