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

func _process(delta):
	#get_tree().call_group("row_5", "change_color_red")
	pass

func enough_spaces() -> bool:
	if available_spaces > 0:
		return true
	return false

# Fills the spaces with blocks.
func fill_spaces():
	available_spaces = max_spaces
	texts = global_text.bingo_text.duplicate()
	box_tracker = []
	
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
			add_to_correct_group(y, x, square)
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
	check_if_collumn()
	check_if_row()
	print(actual_space_tracker)
	pass

func update_space_tracker():
	actual_space_tracker = []
	for i in range(bingo_height):
		actual_space_tracker.append([])
		for j in range(bingo_lenght):
			actual_space_tracker[i].append(box_tracker[i][j].current_state)

func check_if_row():
	for i in range(bingo_height):
		if (actual_space_tracker[i].all(func(boolean): return boolean)) == true:
			update_colors_to_red(i, "row")
		else:
			update_colors_to_grey(i, "row")

func check_if_collumn():
	for i in range(bingo_height):
		var complete_squares = 0 
		for j in range(bingo_lenght):
			if actual_space_tracker[j][i] == true:
				complete_squares += 1
		if complete_squares == 5:
			update_colors_to_red(i, "collumn")
		else:
			update_colors_to_grey(i, "collumn")


func add_to_correct_group(x : int, y : int, square):
	if x == 0:
		square.colorRect.add_to_group("row_1")
	if x == 1:
		square.colorRect.add_to_group("row_2")
	if x == 2:
		square.colorRect.add_to_group("row_3")
	if x == 3:
		square.colorRect.add_to_group("row_4")
	if x == 4:
		square.colorRect.add_to_group("row_5")
	
	if y == 0:
		square.colorRect.add_to_group("collumn_1")
	if y == 1:
		square.colorRect.add_to_group("collumn_2")
	if y == 2:
		square.colorRect.add_to_group("collumn_3")
	if y == 3:
		square.colorRect.add_to_group("collumn_4")
	if y == 4:
		square.colorRect.add_to_group("collumn_5")


func update_colors_to_red(number : int, row_or_collumn : String):
	if row_or_collumn == "row":
		if number == 0:
			get_tree().call_group("row_1", "change_color_red")
		elif number == 1:
			get_tree().call_group("row_2", "change_color_red")
		elif number == 2:
			get_tree().call_group("row_3", "change_color_red")
		elif number == 3:
			get_tree().call_group("row_4", "change_color_red")
		elif number == 4:
			get_tree().call_group("row_5", "change_color_red")
	elif row_or_collumn == "collumn":
		if number == 0:
			get_tree().call_group("collumn_1", "change_color_red")
		elif number == 1:
			get_tree().call_group("collumn_2", "change_color_red")
		elif number == 2:
			get_tree().call_group("collumn_3", "change_color_red")
		elif number == 3:
			get_tree().call_group("collumn_4", "change_color_red")
		elif number == 4:
			get_tree().call_group("collumn_5", "change_color_red")

func update_colors_to_grey(number : int, row_or_collumn : String):
	if row_or_collumn == "row":
		if number == 0:
			get_tree().call_group("row_1", "change_color_grey")
		elif number == 1:
			get_tree().call_group("row_2", "change_color_grey")
		elif number == 2:
			get_tree().call_group("row_3", "change_color_grey")
		elif number == 3:
			get_tree().call_group("row_4", "change_color_grey")
		elif number == 4:
			get_tree().call_group("row_5", "change_color_grey")
	elif row_or_collumn == "collumn":
		if number == 0:
			get_tree().call_group("collumn_1", "change_color_grey")
		elif number == 1:
			get_tree().call_group("collumn_2", "change_color_grey")
		elif number == 2:
			get_tree().call_group("collumn_3", "change_color_grey")
		elif number == 3:
			get_tree().call_group("collumn_4", "change_color_grey")
		elif number == 4:
			get_tree().call_group("collumn_5", "change_color_grey")
