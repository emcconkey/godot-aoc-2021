extends Spatial

func _ready():
	pass # Replace with function body.

func go(mainscript):
	var out = ""
	mainscript.debug_print("Day one part 2 running\n")
	var data = mainscript.read_file('day1.txt')
	var input = data.split('\n')
	for i in input:
		var first = int(i.strip_edges())
		for j in input:
			var second = int(j.strip_edges())
			for k in input:
				var third = int(k.strip_edges())
				if first + second + third == 2020:
					out += "First: " + str(first) + "\n"
					out += "Second: " + str(second) + "\n"
					out += "Third: " + str(third) + "\n"
					out += "Result: " + str(first*second*third) + "\n"
					return out

	return "Error: not found"
	