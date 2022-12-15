lithium = require 'lithium.init'
import table, util from lithium
import printi from util

grid = [table.imap table.array(line\gmatch'.'), tonumber for line in io.lines!]
gridWidth = #grid[1]
gridHeight = #grid

visible = (gridHeight - 1) * 2 + (gridWidth - 1) * 2

maxScenicScore = 0
for y = 2, gridHeight - 1
	for x = 2, gridWidth - 1
		height = grid[y][x]
		
		hl = table.reduce [item for item in *grid[y][1,x-1]], math.max
		hr = table.reduce [item for item in *grid[y][x+1,gridWidth]], math.max
		ht = table.reduce [row[x] for row in *grid[1,y-1]], math.max
		hb = table.reduce [row[x] for row in *grid[y+1,gridHeight]], math.max
		visible += 1 if height > math.min hl, hr, ht, hb
		
		scenicScore = 1
		for delta in *{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
			coord = {y, x}
			dist = 0
			while true
				coord[1] += delta[1]
				coord[2] += delta[2]
				other = table.index grid, coord[1], coord[2]
				break unless other
				dist += 1
				break if other >= height
			scenicScore *= dist
		maxScenicScore = math.max maxScenicScore, scenicScore

print "trees visible: #{visible}"
print "best scenic score: #{maxScenicScore}"