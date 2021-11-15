extends Area

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func button_ready(body):
	if(body.is_player):
		body.set_ready_button(self.owner)


func button_unready(body):
	if(body.is_player):
		body.set_ready_button(false)

