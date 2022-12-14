lithium = require 'lithium.init'
import comb, table from lithium

emptyCell = comb.literal'   ' / -> ''
filledCell = comb.pattern'%[(%a)%]' / (result) -> result.captures[1]

cellRow = (emptyCell + filledCell)\delimited comb.literal' '
numberRow = comb.pattern' %d '\delimited comb.literal' '

rows = cellRow\delimited comb.newline

instruction = comb.pattern'move (%d+) from (%d+) to (%d+)'\index'captures' / (result) -> [tonumber n for n in *result]
instructions = instruction\delimited comb.newline

program = comb.sequence({
	rows
	comb.newline
	numberRow
	comb.newline
	comb.newline
	instructions
	comb.eof
}) / (result) -> {rows: result[1], instructions: result[6]}

ctx =
	index: 1
	data: io.read '*a'

data = program(ctx).result
colCount = table.reduce [#row for row in *data.rows], math.max
_cols = [{} for i = 1, colCount]
for i, row in table.ripairs data.rows
	for j, v in ipairs row
		continue if v == ''
		table.insert _cols[j], v

with cols = table.clone _cols
	for inst in *data.instructions
		{[1]: icount, [2]: fro, [3]: to} = inst
		cfrom = cols[fro]
		cto = cols[to]
		for i = 1, icount
			assert #cfrom > 0
			table.insert cto, cfrom[#cfrom]
			cfrom[#cfrom] = nil

	answer = table.concat [col[#col] for col in *cols]
	print "answer (cratemover 9000): #{answer}"

with cols = table.clone _cols
	for inst in *data.instructions
		{[1]: icount, [2]: fro, [3]: to} = inst
		cfrom = cols[fro]
		cto = cols[to]
		index = #cfrom - icount + 1
		for i = 1, icount
			assert #cfrom > 0
			table.insert cto, cfrom[index]
			table.remove cfrom, index

	answer = table.concat [col[#col] for col in *cols]
	print "answer (cratemover 9001): #{answer}"