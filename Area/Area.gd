extends Node2D
	
var area_data = {}
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var text_container = $VBoxContainer
	var area_menu_name = str(area_data.position) + "_menu"
	var area_button = _create_area_button("SELECT", area_menu_name)
	var area_menu = _create_area_menu(area_menu_name)
	area_button.text = "SELECT"
	area_button.connect("pressed", func(): _display_area_menu(area_button.get_meta("area_name")))
	var area_label = Label.new()
	area_label.text = "AREA " + area_data.name
	text_container.add_child(area_label)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _display_area_menu(area_name):
	var target_area = get_node(area_name)
	if target_area.visible:
		target_area.visible = false
	else:
		target_area.visible = true
	count += 1
	print(str(count))
	print(target_area.visible)
	
func _create_area_menu(area_name):
	var area_menu = PopupPanel.new()
	area_menu.name = area_name
	var menu_item = Label.new()
	menu_item.text = "Menu: " + str(area_data.name)
	area_menu.add_child(menu_item)
	self.add_child(area_menu)
	return area_menu
	
func _create_area_button(label, area_name):
	var button = Button.new()
	button.set_focus_mode(0)
	button.text = label
	add_child(button)
	button.set_meta("area_name", area_name)
	return button
	
	
