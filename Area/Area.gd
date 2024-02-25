extends Node2D
	
var area_data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var text_container = $VBoxContainer
	var area_label = Label.new()
	area_label.text = "AREA " + area_data.name
	text_container.add_child(area_label)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
