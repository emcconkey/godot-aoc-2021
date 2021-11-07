extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	set_label("This is a label")

func set_label(t):
	$Sprite3D/Viewport/Label.text = t

