extends TileMap

const Minesweeper = preload("res://minesweeper.gd")

var rows = 14
var cols = 18
var ms = Minesweeper.new()
var buttons = []
var started = false
var startTime
var elapsedLabel 

func _init():
	pass

func _ready():
	elapsedLabel = Label.new()
	elapsedLabel.set_text("0")
	elapsedLabel.set_position(Vector2(1140, 420))
	self.add_child(elapsedLabel)
	for i in range(cols):
		buttons.append([])
		for j in range(rows):
			var button = Button.new()
			button.set_position(Vector2(i * 60, j * 60))
			button.set_size(Vector2(60, 60))
			button.show()
			button.connect("gui_input", self, "on_button_press", [i, j])
			buttons[i].append(button)
			self.add_child(button)

func on_button_press(event, i: int, j: int):
	if event is InputEventMouseButton and event.pressed:
		if !started:
			started = true
			startTime = OS.get_unix_time()
		print(str(j) + " " + str(i))
		if event.button_index == BUTTON_LEFT:
			match ms.open(j, i):
				ms.OpenResult.GameWon:
					globals.set_completion_time(elapsedLabel.get_text())
					get_tree().change_scene("res://game_won.tscn")
				ms.OpenResult.GameOver:
					get_tree().change_scene("res://game_over.tscn")
			self.update_buttons()
		elif event.button_index == BUTTON_RIGHT:
			ms.mark(j, i)
			self.update_buttons()
	
func update_buttons():
	for i in range(ms.cur_board.size()):
		for j in range(ms.cur_board[0].size()):
			if ms.cur_board[i][j] == -2:
				continue
			elif ms.cur_board[i][j] == -3:
				buttons[j][i].set_text("flag")
			else:
				buttons[j][i].set_text(str(ms.cur_board[i][j]))
	
func _process(_delta):
	var time = OS.get_unix_time()
	if started:
		elapsedLabel.set_text(str(time - startTime))
