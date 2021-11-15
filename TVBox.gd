extends Spatial

var current_day = 0
var clicking = false

export var monitor:NodePath
export var debug_monitor:NodePath

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_text(t, debug=false):
	var mon:NodePath

	if debug:
		mon = debug_monitor
	else:
		mon = monitor

	get_node(mon).text = t

func add_text(t, debug=false):
	var mon:NodePath

	if debug:
		mon = debug_monitor
	else:
		mon = monitor

	var text = get_node(mon).text
	text = text + t
	var lines = text.split('\n')
	text = ""
	var start = lines.size() - 19
	if start < 0:
		start = 0

	for i in range(start, lines.size()):
		if lines[i] != "":
			text += (lines[i])
			if i < lines.size() - 1:
				text += "\n"
	
	get_node(mon).text = text

func click_button(player):
	if clicking:
		return false	
	player.get_parent().run_day(current_day)
	clicking = true
	yield(get_tree().create_timer(1.0), "timeout")
	clicking = false
 
func process_input():
	pass
