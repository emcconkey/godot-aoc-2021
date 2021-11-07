extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var label = preload("res://3dLabel2.tscn")
var box = preload("res://TVBox.tscn")
var debugbox = preload("res://DebugBox.tscn")
var splash = preload("res://SplashScreen.tscn")
var splash_screen
var days = range(0,100)
var boxes = range(0,100)
var processing = range(0, 100)
var ui_open = true

# Called when the node enters the scene tree for the first time.
func _ready():
	splash_screen = splash.instance()
	open_ui()
	$Player.translate(Vector3(-8,1,-3))
	var b = debugbox.instance()
	add_child(b)
	b.translate(Vector3(10,0,24))
	b.rotate(Vector3.UP, deg2rad(180))
	add_day(1, "day_one_part_one", "Day 1: Part 1\nPress button to start!\n")
	add_day(2, "day_one_part_two", "Day 1: Part 2\nPress button to start!\n")
	add_day(3, "day_two_part_one", "Day 2: Part 1\nPress button to start!\n")
	add_day(4, "day_two_part_two", "Day 2: Part 2\nPress button to start!\n")
	add_day(5, "day_three_part_one", "Day 3: Part 1\nPress button to start!\n")
	add_day(6, "day_three_part_two", "Day 3: Part 2\nPress button to start!\n")


func close_ui():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	remove_child(splash_screen)
	ui_open = false

func open_ui():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	add_child(splash_screen)
	ui_open = true


func run_day(day):
	print("running day " + str(day))
	var thread = Thread.new()
	thread.start(self, "run_day_thread", day)


func add_day(num, function_name, text):
	days[num] = function_name
	var b = box.instance()
	boxes[num] = b
	add_child(b)
	b.translate(Vector3(4*num, 1, 0))
	b.rotate(Vector3.UP, deg2rad(0))
	b.set_label(text)
	processing[num] = false
	b.current_day = num

func run_day_thread(day):
	if processing[day] == true:
		return false
	processing[day] = true
	boxes[day].add_text("Running %s\n" % [ days[day] ])
	var load_scene = load("res://days/" + days[day] + ".tscn")
	var scene = load_scene.instance()
	add_child(scene)

	var start = OS.get_ticks_usec()
	var result = scene.go(self)
	var end = OS.get_ticks_usec()
	var work_time = (end-start)/1000000.0

	boxes[day].add_text(result)
	boxes[day].add_text("Done in: %s\n" % [ work_time ])
	processing[day] = false
	scene.queue_free()

func read_file(filename):
	var file = File.new()
	file.open("res://" + filename, File.READ)
	var content = file.get_as_text()
	file.close()
	return content

func debug_print(t):
	$DebugBox.add_text(t)
