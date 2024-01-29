extends ColorRect

@export_enum("Unchecked", "Checked") var current_state = "Unchecked"

var mouse_inside : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if mouse_inside:
		if Input.is_action_just_pressed("LMB") and current_state == "Unchecked": 
			self.color = Color(0.92, 1, 0.13, 0.7)
			current_state = "Checked"
		elif Input.is_action_just_pressed("LMB") and current_state == "Checked":
			self.color = Color(1, 1, 1, 0.7)
			current_state = "Unchecked"
		


func _on_mouse_entered():
	mouse_inside = 1




func _on_mouse_exited():
	mouse_inside = 0
