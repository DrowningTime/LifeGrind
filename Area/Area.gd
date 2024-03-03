extends Node2D

var area_data = {}
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var text_container = $VBoxContainer
	text_container.name = str(area_data.position) + "_container"
	var area_menu_name = str(area_data.position) + "_menu"
	var area_label = _create_area_label(text_container)
	var area_button = _create_area_button("SELECT", area_menu_name, area_label)
	var area_menu = _create_area_menu(area_menu_name, area_label)
	area_button.connect("pressed", func(): _display_area_menu(area_button.get_meta("area_name")))

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

func _create_area_menu(area_name, area_label):
	var area_menu_scene = preload("res://UI/Area_Menu.tscn")
	var area_menu = area_menu_scene.instantiate()
	area_menu.name = area_name
	area_menu.area_data = area_data
	self.add_child(area_menu)
	var menu_position = area_label.global_position + Vector2((area_label.get_size().x - area_menu.get_size().x) / 2, area_label.get_size().y)
	area_menu.global_position = menu_position
	return area_menu

func _create_area_button(label, area_name, area_label):
	var button = Button.new()
	button.set_focus_mode(0)
	button.text = "SELECT"
	button.name = area_name + "_button"
	add_child(button)
	button.set_meta("area_name", area_name)
	var button_position = Vector2((area_label.get_size().x - button.get_size().x) / 2, area_label.get_size().y)
	button.global_position = button_position
	return button

func _create_area_label(container):
	var area_label = Label.new()
	area_label.name = str(area_data.position) + "_label"
	area_label.text = "AREA: " + area_data.name
	container.add_child(area_label)
	var area_label_position = area_label.global_position + Vector2((container.get_size().x - area_label.get_size().x) / 2, container.get_size().y)
	area_label.global_position = area_label_position
	return area_label
