extends Spatial
var mutex

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	mutex = Mutex.new()
	pass # Replace with function body.


func set_label(t):
	$Sprite3D/Viewport/Label.text = t

func add_text(t):
	mutex.lock()
	var text = $Sprite3D/Viewport/Label.text
	text = text + t
	var lines = text.split('\n')
	text = ""
	var start = lines.size() - 60
	if start < 0:
		start = 0

	for i in range(start, lines.size()):
		if lines[i] != "":
			text += (lines[i] + "\n")
	
	$Sprite3D/Viewport/Label.text = text
	mutex.unlock()