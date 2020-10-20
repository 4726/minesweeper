extends Node

func _ready():
	if networking.nakama_session == null:
		print("could not connect to server")
		get_tree().change_scene("res://main_menu.tscn")
		return
	var res = networking.get_leaderboard()
	if res.is_exception():
		print("get leaderboard error: %s" % res)
	else:
		for v in res.records:
			var label = Label.new()
			label.set_text("%s %s" % [v.username, v.score])
			self.add_child(label)

func _input(event):
	if event.is_pressed() && event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://main_menu.tscn")
