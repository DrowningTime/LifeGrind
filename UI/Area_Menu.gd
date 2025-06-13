extends Control

var area_data = {}
var menu_slots = 6
signal close_area_menu_pressed()


func _ready():
	pass

#Update Area Menu button values based on Subarea data
func update_menu(area_data):
	$MarginContainer/AreaMenuContainer/AreaMenuHBoxContainer/SubareaValueVBoxContainer/AreaMenuNameValue.text=area_data.name
	if area_data.subareas.size() == 0 :
		var subarea_label = get_node("MarginContainer/AreaMenuContainer/AreaMenuHBoxContainer/SubareaNameVBoxContainer/AreaMenuSubArea{index}Label".format({"index": 0}))
		subarea_label.max_lines_visible = 1
		#subarea.text=area_data.subareas[i].name
		#add items
	else:
		for i in area_data.subareas:
			var subarea_label = get_node("MarginContainer/AreaMenuContainer/AreaMenuHBoxContainer/SubareaNameVBoxContainer/AreaMenuSubArea{index}Label".format({"index": i.position}))
			var subarea_value = get_node("MarginContainer/AreaMenuContainer/AreaMenuHBoxContainer/SubareaValueVBoxContainer/AreaMenuSubArea{index}Value".format({"index": i.position}))
			subarea_label.max_lines_visible = 1
			subarea_label.text = area_data.subareas[i.position].name
			subarea_value.max_lines_visible = 1
			subarea_value.text = area_data.subareas[i.position].name
	#if area_data.subareas.size() != 0:
		#for subarea in area_data.subareas:
			#add_menu_item(menu_container, subarea)	
	
	
func _on_area_menu_close_button_pressed():
	emit_signal("close_area_menu_pressed")
	print("close pressed")
	
func _clear_menu_values():
	for i in area_data.subareas:
