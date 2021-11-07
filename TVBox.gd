extends Spatial

var current_day = 0
var clicking = false
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_label(t):
	$Sprite3D/Viewport/Label.text = t

func add_text(t):
	var text = $Sprite3D/Viewport/Label.text
	text = text + t
	var lines = text.split('\n')
	text = ""
	var start = lines.size() - 11
	if start < 0:
		start = 0

	for i in range(start, lines.size()):
		if lines[i] != "":
			text += (lines[i] + "\n")
	
	$Sprite3D/Viewport/Label.text = text

func click_button():
	if clicking:
		return false
	clicking = true
	$Button.translate_object_local($Button.transform.basis.z*5)
	yield(get_tree().create_timer(1.0), "timeout")
	$Button.translate_object_local($Button.transform.basis.z*-5)
	clicking = false
