extends Spatial

func _ready():
	pass # Replace with function body.

func go(mainscript):
	mainscript.debug_print("Day one part 1 running\n")
	var data = mainscript.read_file('inputs/day1.txt')
	var input = data.split('\n')
	for i in input:
		var first = int(i.strip_edges())
		for j in input:
			var second = int(j.strip_edges())
			if first + second == 2020:
				mainscript.print("First: " + str(first) + "\n")
				mainscript.print("Second: " + str(second) + "\n")
				mainscript.print("Result: " + str(first*second) + "\n")
				return
	mainscript.print("Error: not found!\n")
