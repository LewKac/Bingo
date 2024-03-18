extends ColorRect

enum States {Unpressed, Pressed, Row}

signal mouse_pressed(new_color : Color, new_state : bool) # Used to change color
signal tile_change(pressed : bool) # Used to send signal to game board

var current_state : States = States.Unpressed
var mouse_inside : bool # Used to check if mouse is inside the tile

const COLOR_CHECKED = Color(0.92, 1, 0.13, 0.7)
const COLOR_UNCKECKED = Color(1, 1, 1, 0.7)
const COLOR_ROW = Color(0.9, 0.2, 0.2, 0.7)

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_pressed.connect(change_state)
	pass # Replace with function body.

func _process(_delta):
	if mouse_inside:
		if Input.is_action_just_pressed("LMB") and current_state == States.Unpressed: 
			mouse_pressed.emit(States.Pressed)
			tile_change.emit(true)
		elif Input.is_action_just_pressed("LMB") and current_state == States.Pressed:
			mouse_pressed.emit(States.Unpressed)
			tile_change.emit(false)

func _on_mouse_entered():
	mouse_inside = true

func _on_mouse_exited():
	mouse_inside = false

func change_color_red():
	print("I triggered in red")
	self.color = COLOR_ROW

func change_state(state : States):
	if state == States.Unpressed:
		current_state = States.Unpressed
	if state == States.Pressed:
		current_state = States.Pressed
	if state == States.Row:
		current_state = States.Row
	update_color() 

func update_color():
	match current_state:
		States.Pressed:
			self.color = COLOR_UNCKECKED
		States.Unpressed:
			self.color = COLOR_CHECKED
		States.Row:
			self.color = COLOR_ROW 
