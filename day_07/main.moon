lithium = require 'lithium.init'
import comb, table from lithium

file = comb.pattern'(%d+)%s+([^\r\n]+)' / (result) -> {tag: 'file', size: tonumber(result.captures[1]), name: result.captures[2]}
directory = comb.pattern'dir%s+([^\r\n]+)' / (result) -> {tag: 'directory', name: result.captures[1]}
cdroot = comb.literal'$ cd /' / -> {tag: 'root'}
cdup = comb.literal'$ cd ..' / -> {tag: 'up'}
cd = comb.pattern'$ cd ([^\r\n]+)' / (result) -> {tag: 'cd', name: result.captures[1]}
ls = comb.literal'$ ls' / -> {tag: 'ls'}

listing = ls * comb.newline * (directory + file)\delimited(comb.newline)\tag'listing'

output = (cdup + cdroot + cd + listing)\delimited(comb.newline)

ctx =
	index: 1
	data: io.read '*a'

commands = output(ctx).result

pwd = {}

fs = {}

for command in *commands
	switch command.tag
		when 'up'
			pwd[#pwd] = nil
		when 'root'
			pwd = {}
		when 'cd'
			table.insert pwd, command.name
		when 'listing'
			for node in *command.value
				if node.tag == 'file'
					table.set fs, table.unpack table.imerge(pwd, {node.name, node.size})
				elseif node.tag == 'directory'
					nil
				else
					error "unknown node type: #{node.tag}"

directorySizes = {}
totalSizeUnder100000 = 0
calcSize = (node) ->
	return node if 'number' == type node
	unless node.size
		node.size = table.reduce [calcSize subnode for k, subnode in pairs node]
		totalSizeUnder100000 += node.size if node.size <= 100000
		table.insert directorySizes, node.size
	return node.size

calcSize fs

print "size sum: #{totalSizeUnder100000}"

directorySizes = table.sort directorySizes

diskSpace = 70000000
spaceAvailable = diskSpace - fs.size
spaceNeeded = 30000000
for size in *directorySizes
	if spaceAvailable + size >= spaceNeeded
		print "smallest viable directory size: #{size}"
		break