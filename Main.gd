extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var box_preload = preload("res://TVBox.tscn")
var splash_preload = preload("res://SplashScreen.tscn")
var splash_screen
var current_box
var current_day
var current_function
var processing
var ui_open = true
var input_captured = false


# Called when the node enters the scene tree for the first time.
func _ready():
	splash_screen = splash_preload.instance()
	open_ui()
	$Player.translate(Vector3(-1,-1,-1))
	add_day(1, "day_one_part_one", "Press 'E' to start!\nC:\\> \n")


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
	thread.start(self, "run_day_thread", [ day, thread ])

func add_day(num, function_name, text):
	current_box = box_preload.instance()
	add_child(current_box)
	current_box.translate(Vector3(5*num, 1, 0))
	current_box.rotate(Vector3.UP, deg2rad(0))
	current_box.set_text(text)
	current_box.set_text("Debug screen ready...\n", true)
	current_function = function_name
	processing = false
	current_box.current_day = num

func run_day_thread(input):
	var day = input[0]
	var thread = input[1]
	var filename = "res://days/" + current_function + ".tscn"
	if processing == true:
		return false
	processing = true
	current_box.add_text("Running %s\n" % [ current_function ])

	var directory = Directory.new();
	var doFileExists = directory.file_exists(filename)
	if !doFileExists:
		current_box.add_text("Error: coult not load %s\n" % [ filename ])
		processing = false
		return

	var load_scene = load(filename)
	var scene = load_scene.instance()
	add_child(scene)

	var start = OS.get_ticks_usec()
	scene.go(self)
	var end = OS.get_ticks_usec()
	var work_time = (end-start)/1000000.0

	current_box.add_text("Done in: %s\nC:\\> " % [ work_time ])
	processing = false
	scene.queue_free()
	call_deferred("finish_thread", thread)

func finish_thread(thread):
	thread.wait_to_finish()

func read_file(filename):
	var file = File.new()
	file.open("res://" + filename, File.READ)
	var content = file.get_as_text()
	file.close()
	return content

func debug_print(t):
	#debug_screen.add_text(t)
	current_box.add_text(t, true)

func print(t):
	current_box.add_text(t)
