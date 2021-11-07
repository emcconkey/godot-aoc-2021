extends Spatial

func _ready():
	pass # Replace with function body.

func go(mainscript):
	mainscript.debug_print("Day one part 1 running\n")
	var data = mainscript.read_file('day1.txt')
	var input = data.split('\n')
	for i in input:
		var first = int(i.strip_edges())
		for j in input:
			var second = int(j.strip_edges())
			if first + second == 2020:
				var out = ""
				out += "First: " + str(first) + "\n"
				out += "Second: " + str(second) + "\n"
				out += "Result: " + str(first*second) + "\n"
				return out
	return "Error: not found"

# func go(mainscript):
# 	var data = mainscript.read_file('day1.txt')
# 	var input = data.split('\n')
# 	for i in input:
# 		var first = int(i.strip())
# 		for j in input:
# 			var second = int(j.strip())
# 			for k in input:
# 				var third = int(k.strip())
# 				if first + second + third == 2020:
# 					print(first * second * third)
# 					return
# 			if first + second == 2020:
# 				print(first)
# 				print(second)
# 				print(first * second)
# 				return

# 	return data
	