extends Node

var rows = 14
var cols = 18
var mines = 40

var board = []
# mine = -1
var cur_board = []
# unexplored = -2
# mine = -1
var rand = RandomNumberGenerator.new()

		
func _init():
	rand.randomize()
	for i in range(rows):
		board[i] = []
		cur_board[i] = []
		for j in range(cols):
			board[i][j] = 0
			cur_board[i][j] = -2
	generate()



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func open(x, y):
	if cur_board[x][y] != -2:
		#already explored
		return
	if board[x][y] == -1:
		#game_over
		pass
	else:
		cur_board[x][y] = board[x][y]
		dfs(x, y, {})

func dfs(x, y, map):
	var dirs = []
	dirs.append([0, 1])
	dirs.append([1, 1])
	dirs.append([-1, 1])
	dirs.append([0, -1])
	dirs.append([1, -1])
	dirs.append([-1, -1])
	dirs.append([1, 0])
	dirs.append([-1, 0])
	for i in range(dirs):
		var x2 = x + dirs[i][0]
		var y2 = y + dirs[i][1]
		if x2 < 0 || y2 < 0 || x2 == rows || y2 == cols:
			continue
		if map.has([x2, y2]):
			continue
		if board[x2][y2] == 0:
			map[[x, y]] = true
			cur_board[x2][y2] = 0
			dfs(x2, y2, map)

func generate():
	for i in range(rows):
		for j in range(cols):
			if board[i][j] == -1:
				continue
			board[i][j] = mines_around(i, j)
			
func generate_mine_locations():
	var finished = 0
	while finished < mines:
		var rand_x = rand.randi_range(0, rows-1)
		var rand_y = rand.randi_range(0, cols-1)
		if board[rand_x][rand_y] != -1:
			board[rand_x][rand_y] = -1
			finished += 1
			
func mines_around(x, y):
	var dirs = []
	dirs.append([0, 1])
	dirs.append([1, 1])
	dirs.append([-1, 1])
	dirs.append([0, -1])
	dirs.append([1, -1])
	dirs.append([-1, -1])
	dirs.append([1, 0])
	dirs.append([-1, 0])
	var cnt = 0
	for i in range(dirs):
		var x2 = x + dirs[i][0] 
		var y2 = y + dirs[i][1]
		if x2 < 0 || y2 < 0 || x2 == rows || y2 == cols:
			continue
		if board[x2][y2] == -1:
			cnt += 1
	return cnt
