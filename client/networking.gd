extends Node

var nakama_client : NakamaClient
var nakama_session : NakamaSession

func _ready():
	nakama_client = Nakama.create_client("defaultkey", "192.168.99.100", 7350, "http")
	globals.set_player_name("player1")
	nakama_session = yield(nakama_client.authenticate_custom_async(globals.get_player_name()), "completed")
	if nakama_session.is_exception():
		print("create session error: %s" % nakama_session)
	else:
		print("session created")

func disconnect_online():
	#might need to disconnect from server
	nakama_client = null
	nakama_session = null
