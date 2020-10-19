extends MarginContainer

func _on_OfflineGameButton_pressed():
	print("changing to offline board scene")
	get_tree().change_scene("res://board.tscn")

func _on_OnlineGameButton_pressed():
	print("changing to online board scene")
	get_tree().change_scene("res://board_online.tscn")


func _on_LeaderboardButton_pressed():
	print("changing to leaderboard scene")
	get_tree().change_scene("res://leaderboard.tscn")
