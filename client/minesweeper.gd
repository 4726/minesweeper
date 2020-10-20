var rows = 14
var cols = 18
var mines = 40

var board = []
# mine = -1
var cur_board = []
# marked = -3
# unexplored = -2
# mine = -1
var rand = RandomNumberGenerator.new()

enum OpenResult {
	GameOver,
	GameWon,
	Continue
}

# Generates a board
func _init():
	rand.randomize()
	for i in range(rows):
		board.append([])
		cur_board.append([])
		for _j in range(cols):
			board[i].append(0)
			cur_board[i].append(-2)
	generate_mine_locations()
	generate()

func open(x: int, y: int):
	if cur_board[x][y] != -2:
		#already explored
		return OpenResult.Continue
	elif board[x][y] == -1:
		#game_over
		return OpenResult.GameOver
	elif board[x][y] == 0:
		cur_board[x][y] = board[x][y]
		dfs2(x, y)
		return OpenResult.Continue
	else:
		cur_board[x][y] = board[x][y]
		if game_won():
			return OpenResult.GameWon
		return OpenResult.Continue
	
func mark(x: int, y: int):
	cur_board[x][y] = -3
	print("marked")

func dfs2(x: int, y: int):
	var dirs = []
	dirs.append([0, 1])
	dirs.append([1, 1])
	dirs.append([-1, 1])
	dirs.append([0, -1])
	dirs.append([1, -1])
	dirs.append([-1, -1])
	dirs.append([1, 0])
	dirs.append([-1, 0])
	for d in dirs:
		var x2 = x + d[0]
		var y2 = y + d[1]
		if x2 < 0 || y2 < 0 || x2 == rows || y2 == cols:
			continue
		if cur_board[x2][y2] != -2:
			continue
		if board[x2][y2] == 0:
			cur_board[x2][y2] = 0
			dfs2(x2, y2)
		elif board[x2][y2] > 0:
			cur_board[x2][y2] = board[x2][y2]

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
			
func mines_around(x: int, y: int):
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
	for d in dirs:
		var x2 = x + d[0] 
		var y2 = y + d[1]
		if x2 < 0 || y2 < 0 || x2 == rows || y2 == cols:
			continue
		if board[x2][y2] == -1:
			cnt += 1
	return cnt

# returns true if game won
func game_won():
	for i in range(rows):
		for j in range(cols):
			if cur_board[i][j] != -2:
				return false
	return true

func encode_board():
	var arr = PoolByteArray()
	var cur = 0
	var bit = 0
	for i in range(rows):
		for j in range(cols):
			if board[i][j] == -1:
				cur |= 1 << bit 
			bit += 1
			if bit == 8 || (i == rows-1 && j == cols-1):
				bit = 0
				arr.append(cur)
				cur = 0
	return arr

func decode_board(arr: PoolByteArray):
	var board1 = []
	for i in range(rows):
		board1.append([])
		for _j in range(cols):
			board1[i].append(0)
	var sets = []
	for v in arr:
		for i in range(8):
			if (v >> i) % 2 == 1:
				sets.append(true)
			else:
				sets.append(false)
	var k = 0
	for i in range(rows):
		for j in range(cols):
			if sets[k]:
				board1[i][j] = -1
			k += 1
	return board1
