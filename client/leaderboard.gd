extends Node

func _ready():
	var res = yield(networking.nakama_client.list_leaderboard_records_async(networking.nakama_session, "scores"), "completed")
	if res.is_exception():
		print("get leaderboard error: %s" % res)
	else:
		for v in res.records:
			var label = Label.new()
			label.set_text("%s %s" % [v.username, v.score])
			self.add_child(label)

func _input(event):
	if event.is_pressed() && event.button_index == BUTTON_LEFT:
		networking.disconnect_online()
		get_tree().change_scene("res://main_menu.tscn")
