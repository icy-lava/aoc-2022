lithium = require 'lithium.init'
import table from lithium

lines = [line for line in io.lines!]

priority = {v, i for i, v in ipairs [char for char in 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'\gmatch '.']}

findCommon = (a, b) ->
	found = {}
	for c in a\gmatch '.'
		found[c] = true
	common = ''
	for c in b\gmatch '.'
		if found[c]
			common ..= c
	return common

splitInHalf = (str) -> str\sub(1, #str / 2), str\sub #str / 2 + 1

score = table.reduce [priority[findCommon(splitInHalf line)\sub 1, 1] for line in *lines]
print "final score (part 1): #{score}"

badges = {}
cor = coroutine.wrap ->
	while true
		badge = coroutine.yield!
		badge = findCommon badge, coroutine.yield!
		badge = findCommon badge, coroutine.yield!
		table.insert badges, badge\sub(1, 1)
cor!

for line in *lines do cor line

score = table.reduce [priority[badge] for badge in *badges]
print "final score (part 2): #{score}"