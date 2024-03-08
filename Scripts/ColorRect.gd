extends ColorRect

@export_enum("Unpressed", "Pressed") var current_state = "Unpressed"
signal mouse_pressed(new_color : Color, new_state : bool) # Used to change color
signal tile_change(pressed : bool) # Used to send signal to game board

var mouse_inside : bool # Used to check if mouse is inside the tile

const COLOR_CHECKED = Color(0.92, 1, 0.13, 0.7)
const COLOR_UNCKECKED = Color(1, 1, 1, 0.7)
const COLOR_ROW = Color(0.9, 0.2, 0.2, 0.7)

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_pressed.connect(change_color)
	pass # Replace with function body.

func _process(_delta):
	if mouse_inside:
		if Input.is_action_just_pressed("LMB") and current_state == "Unpressed": 
			mouse_pressed.emit(COLOR_CHECKED, true)
			tile_change.emit(true)
		elif Input.is_action_just_pressed("LMB") and current_state == "Pressed":
			mouse_pressed.emit(COLOR_UNCKECKED, false)
			tile_change.emit(false)



func _on_mouse_entered():
	mouse_inside = true

func _on_mouse_exited():
	mouse_inside = false

func change_color(new_color : Color, new_state : bool):
	#self.color = new_color
	if new_state == true:
		current_state = "Pressed"
	else:
		current_state = "Unpressed"

func change_color_red():
	print("I triggered in red")
	self.color = COLOR_ROW

func change_color_grey():
	pass
	if current_state == "Pressed":
		self.color = COLOR_CHECKED
	else:
		self.color == COLOR_UNCKECKED

