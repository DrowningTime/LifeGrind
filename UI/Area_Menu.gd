extends Control

var area_data = {}

func _ready():
	var color_rect = _create_menu_background()
	var menu_container = _map_subareas(color_rect)
	self.visible = false
	await get_tree().create_timer(.1).timeout
	resize_background(color_rect,menu_container.size)
	
func _map_subareas(color_rect):
	var box_container = BoxContainer.new()
	box_container.vertical=true
	box_container.set_alignment(1)
	box_container.size_flags_vertical = BoxContainer.SIZE_EXPAND_FILL  # Set vertical size flags
	color_rect.add_child(box_container)
	
	#add menu title
	var label = Label.new()
	label.text = area_data.name + " MENU"
	label.name = area_data.name + "_menulabel"
	label.vertical_alignment=VERTICAL_ALIGNMENT_TOP
	label.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
	box_container.add_child(label)
	
	#add items
	if area_data.subareas.size() != 0:
		for subarea in area_data.subareas:
			#var subarealabel = Label.new()
			#$AreaMenuPolygon2D/AreaMenuBoxContainer.add_child(subarealabel)
			add_menu_item(box_container, subarea.name)
			
	#return container
	print("inside: " + str(box_container.get_size()))
	return box_container

func _create_menu_background():
	var color_rect = ColorRect.new()
	color_rect.color = Color(0, 0, 0)  # Set background color
	#color_rect.set_size(Vector2(200, 100))  # Set initial size
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
