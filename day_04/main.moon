lithium = require 'lithium.init'
import table from lithium
import unpack from table

tonumbers = (...) -> unpack [tonumber n for n in *{...}]

sets = [{tonumbers line\match '(%d+)%-(%d+),(%d+)%-(%d+)'} for line in io.lines!]

containCount = 0
for set in *sets
	if (set[1] <= set[3] and set[2] >= set[4]) or (set[3] <= set[1] and set[4] >= set[2])
		containCount += 1

print "contain count: #{containCount}"

overlapCount = 0
for set in *sets
	if set[2] >= set[3] and set[1] <= set[4]
		overlapCount += 1

print "overlap count: #{overlapCount}"