extends Node

var lastCompleteTime

func set_completion_time(seconds):
	lastCompleteTime = seconds
	
func get_completion_time():
	return lastCompleteTime
