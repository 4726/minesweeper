extends MarginContainer

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_pressed() && event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://main_menu.tscn")
