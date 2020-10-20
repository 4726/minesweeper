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

func update_leaderboard(time: int, board: PoolByteArray):
	var leaderboard_id = "scores"
	var metadata = {
		"board": board,
	}
	var record = yield(nakama_client.write_leaderboard_record_async(nakama_session, leaderboard_id, time, 0, metadata), "completed")
	if record.is_exception():
		print("error putting record: %s" % record)
	else:
		print("successfully updated record: %s %s" % [record.username, record.score])

func get_leaderboard():
	var res = yield(nakama_client.list_leaderboard_records_async(nakama_session, "scores"), "completed")
