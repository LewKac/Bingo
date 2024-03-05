extends MarginContainer

@onready var global_text = get_node("/root/Globals") 
@onready var texts = global_text.bingo_text.duplicate()
@onready var Vbox = get_node("VBoxContainer")

@export var bingo_square : PackedScene  
@export var bingo_height = 5
@export var bingo_lenght = 5

var max_spaces = bingo_height * bingo_lenght
var available_spaces = max_spaces

var box_tracker = []
var actual_space_tracker

# Called when the node enters the scene tree for the first time.
func _ready():
	fill_spaces()


func enough_spaces() -> bool:
	if available_spaces > 0:
		return true
	return false
	


# Fills the spaces with blocks.
func fill_spaces():
	available_spaces = max_spaces
	texts = global_text.bingo_text.duplicate()
	
	for y in bingo_height:
		var hbox = HBoxContainer.new()
		$VBoxContainer.add_child(hbox)
		
		box_tracker.append([])
	
		for x in bingo_lenght:
			var square = bingo_square.instantiate()
			
			# To make sure to add buttons at the end of the filling the board
			if texts.is_empty():
				add_button()
				return
			
			if not enough_spaces():
				add_button()
				return
			
			var chosen_text = randi_range(0, texts.size() - 1) 
			
			if available_spaces == 13: # Place a blank in middle space
				square.set_text("Free space")
			else:
				square.set_text(texts[chosen_text])
				texts.remove_at(chosen_text)
			
			hbox.add_child(square)
			
			#Connect signal from each square to keep track of how many are pressed
			square.colorRect.tile_change.connect(received_signal)
			box_tracker[y].append(square)
			available_spaces -= 1
		
		if not enough_spaces():
			add_button()
			return

func add_button():
	var button = Button.new()
	button.text = "Reset Board"
	Vbox.add_child(button)
	button.pressed.connect(self._button_pressed)
	return


func _button_pressed():
	for n in Vbox.get_children():
		Vbox.remove_child(n)
		n.queue_free()
	fill_spaces()

func received_signal(state):
	update_space_tracker()
	print(actual_space_tracker)
	pass

func update_space_tracker():
	actual_space_tracker = []
	for i in range(5):
		for j in range(5):
			actual_space_tracker.append(box_tracker[i][j].current_state)

func update_colors():
	#if actual_space_tracker[]
	pass
