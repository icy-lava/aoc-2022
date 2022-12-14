lithium = require 'lithium.init'
import table from lithium

scoreRock = 1
scorePaper = 2
scoreScissors = 3
scoreLose = 0
scoreDraw = 3
scoreWin = 6

scoreMap =
	'A X': scoreRock + scoreDraw
	'A Y': scorePaper + scoreWin
	'A Z': scoreScissors + scoreLose
	'B X': scoreRock + scoreLose
	'B Y': scorePaper + scoreDraw
	'B Z': scoreScissors + scoreWin
	'C X': scoreRock + scoreWin
	'C Y': scorePaper + scoreLose
	'C Z': scoreScissors + scoreDraw

lines = [line for line in io.lines!]
score = table.reduce [assert scoreMap[line] for line in *lines]

print "final score (part 1): #{score}"

scoreMap =
	'A X': scoreScissors + scoreLose
	'A Y': scoreRock + scoreDraw
	'A Z': scorePaper + scoreWin
	'B X': scoreRock + scoreLose
	'B Y': scorePaper + scoreDraw
	'B Z': scoreScissors + scoreWin
	'C X': scorePaper + scoreLose
	'C Y': scoreScissors + scoreDraw
	'C Z': scoreRock + scoreWin

score = table.reduce [assert scoreMap[line] for line in *lines]

print "final score (part 2): #{score}"