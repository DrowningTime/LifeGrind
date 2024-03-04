extends Control

var area_data = {}
var color_rect
var menu_container

func _ready():
	color_rect = _create_menu_background()
	menu_container = _map_subareas(color_rect)
	self.visible = false
	await get_tree().create_timer(.1).timeout #needed to allow for menu_container to finish filling before resize
	#resize_background(color_rect,menu_container.size)
	
func _map_subareas(color_rect):
	var box_container = GridContainer.new()
	box_container.name = "area_menu_container"
	color_rect.add_child(box_container)
	
	#add menu title
	var label = Label.new()
	label.text = "AREA MENU"
	label.name = "area_menu_label"
	label.vertical_alignment=VERTICAL_ALIGNMENT_TOP
	label.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
	box_container.add_child(label)
			
	return box_container

func _create_menu_background():
	var color_rect = ColorRect.new()
	color_rect.color = Color(0, 0, 0)  # Set background color
	color_rect.size = Vector2(400, 200)
	color_rect.name = "area_menu_background"
	add_child(color_rect)
	return color_rect

func add_menu_item(container, label_text):
	# Create a Label for the menu item
	var label = Label.new()
	label.text = label_text
	label.name = label_text + "_label"
	container.add_child(label)
	
func resize_background(color_rect,box_container_size):
	color_rect.size = box_container_size
	
func clear_menu():
	for child in menu_container.get_children():
		if child.name != "area_menu_label":
			child.queue_free()
	
func update_menu(area_data):
	clear_menu()
	get_node("area_menu_background/area_menu_container/area_menu_label").text = "AREA: " + area_data.name
	#add items
	if area_data.subareas.size() != 0:
		for subarea in area_data.subareas:
			add_menu_item(menu_container, subarea.name)
