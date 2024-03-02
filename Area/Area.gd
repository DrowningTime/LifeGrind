@tool
extends Node2D

var area_data = {}
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var area_container = $VBoxContainer
	var area_name = str(area_data.position)
	area_container.name = area_name + "_area"
	var area_button = _create_area_button(area_name)
	#var area_menu = _create_area_menu(area_menu_name)
	var area_label = Label.new()
	area_label.text = "AREA " + area_data.name
	area_label.name = str(area_data.position) + "_label"
	#_create_area_menu(area_container, area_name)
	area_container.add_child(area_label)
	area_container.add_child(area_button)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
#func _create_area_menu(area_container, area_name):
	#var area_menu = PopupMenu.new()
	#var menu_title = Control.new()
	#var menu_item = Label.new()
	#area_container.add_child(area_menu)
	#area_menu.name = area_name
	#area_menu.visible = false
	#area_menu.name = area_name + "_menu"
	#menu_title.add_child(menu_item)
	#area_menu.add_child(menu_title)
	#return area_menu
	
func _create_area_button(area_name):
	var button = MenuButton.new()
	button.text = "SELECT"
	var area_menu_button_name = area_name + "_menu_button"
	button.name = area_menu_button_name
	button.get_popup().name = area_name + "_menu"
	if area_data.subareas.size() != 0:
		for subarea in area_data.subareas:
			button.get_popup().add_item(subarea.name)
			print(subarea.name)
	return button
	
	
