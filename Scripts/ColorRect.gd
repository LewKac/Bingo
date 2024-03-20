extends ColorRect

enum States {Unpressed, Pressed, Row}

signal mouse_pressed(state : States) # Used to change color
signal tile_change(pressed : bool) # Used to send signal to game board
signal remove_row(grous : Array)
signal update_Board()

var current_state : States = States.Unpressed
var mouse_inside : bool # Used to check if mouse is inside the tile

const COLOR_CHECKED = Color(0.92, 1, 0.13, 0.7)
const COLOR_UNCKECKED = Color(1, 1, 1, 0.7)
const COLOR_ROW = Color(0.9, 0.2, 0.2, 0.7)

func _ready():
	mouse_pressed.connect(change_state)

func _process(_delta):
	if mouse_inside:
		if Input.is_action_just_pressed("LMB") and current_state == States.Unpressed: 
			tile_change.emit(true)
			mouse_pressed.emit(States.Pressed)
		elif Input.is_action_just_pressed("LMB") and current_state == States.Pressed:
			tile_change.emit(false)
			mouse_pressed.emit(States.Unpressed)
		elif Input.is_action_just_pressed("LMB") and current_state == States.Row:
			remove_row.emit(get_groups())
			tile_change.emit(false)
			mouse_pressed.emit(States.Unpressed)


func _on_mouse_entered():
	mouse_inside = true


func _on_mouse_exited():
	mouse_inside = false
 

func change_state(state : States):
	if state == States.Unpressed:
		current_state = States.Unpressed
	if state == States.Pressed:
		current_state = States.Pressed
	if state == States.Row:
		current_state = States.Row
	update_color() 


func fix_row_to_pressed():
	if current_state == States.Row:
		current_state = States.Pressed
	update_color() 


func update_color():
	match current_state:
		States.Unpressed:
			self.color = COLOR_UNCKECKED
		States.Pressed:
			self.color = COLOR_CHECKED
		States.Row:
			self.color = COLOR_ROW 
