extends Spatial
var mutex
var clicking = false

export var monitor:NodePath
export var button:NodePath

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	mutex = Mutex.new()
	pass # Replace with function body.


func set_label(t):
	get_node(monitor).text = t

func add_text(t):
	mutex.lock()
	var text = get_node(monitor).text
	text = text + t
	var lines = text.split('\n')
	text = ""
	var start = lines.size() - 60
	if start < 0:
		start = 0

	for i in range(start, lines.size()):
		if lines[i] != "":
			text += (lines[i] + "\n")
	
	get_node(monitor).text = text
	mutex.unlock()

func click_button(player):
	if clicking:
		return false
	get_node(monitor).text = "Debug screen is active...\n"
	clicking = true
	get_node(button).translate_object_local(get_node(button).transform.basis.z*5)
	yield(get_tree().create_timer(1.0), "timeout")
	get_node(button).translate_object_local(get_node(button).transform.basis.z*-5)
	clicking = false
