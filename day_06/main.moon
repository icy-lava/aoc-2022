data = io.read '*a'

uniq = (chars) ->
	for i = 1, #chars - 1
		for j = i + 1, #chars
			if chars\sub(i, i) == chars\sub(j, j)
				return false
	return true

firstUniq = (str, size) ->
	for i = 1, #data - size + 1
		if uniq data\sub i, i + size - 1
			return i + size - 1

print "chars processed for start of packet: #{firstUniq data, 4}"

print "chars processed for start of message: #{firstUniq data, 14}"