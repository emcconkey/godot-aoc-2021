extends Spatial
var mutex
var clicking = false

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

func click_button(player):
	if clicking:
		return false
	$Sprite3D/Viewport/Label.text = "Debug screen is active...\n"
	clicking = true
	$Stairs/ButtonPanel/Button.translate_object_local($Stairs/ButtonPanel/Button.transform.basis.z*5)
	yield(get_tree().create_timer(1.0), "timeout")
	$Stairs/ButtonPanel/Button.translate_object_local($Stairs/ButtonPanel/Button.transform.basis.z*-5)
	clicking = false
