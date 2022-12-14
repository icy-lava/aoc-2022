lithium = require 'lithium.init'
import comb, table from lithium

ctx =
	index: 1
	data: io.stdin\read '*a'

number = comb.digits / (value) -> tonumber value
calories = number\delimited comb.newline
elves = calories\delimited (comb.newline * comb.newline)

data = elves(ctx).result

data = [table.reduce elf for elf in *data]
maxCalories = table.reduce data, math.max

print "highest calories: #{maxCalories}"

data = table.sort data
maxCaloriesTop3 = table.reduce [item for item in *data[#data - 3 + 1,]]

print "top 3 total: #{maxCaloriesTop3}"