extends Node

var lastCompleteTime
var player_name = ""

func set_player_name(name):
	player_name = name

func get_player_name():
	return player_name

func set_completion_time(seconds):
	lastCompleteTime = seconds
	
func get_completion_time():
	return lastCompleteTime
