extends MarginContainer

func _ready():
	set_process_input(true)
	var completionTimeLabel = get_node("VBoxContainer/Label3")
	completionTimeLabel.set_text(str(globals.get_completion_time()))

func _input(event):
	if event.is_pressed() && event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://main_menu.tscn")
