extends MarginContainer

@onready var global_text = get_node("/root/Globals") 
@onready var texts = global_text.bingo_text.duplicate()
@onready var Vbox = get_node("VBoxContainer")

@export var bingo_square : PackedScene  
@export var bingo_height = 5
@export var bingo_lenght = 5

var max_spaces = bingo_height * bingo_lenght
var available_spaces = max_spaces


# Called when the node enters the scene tree for the first time.
func _ready():
	fill_spaces()


func enough_spaces() -> bool:
	if available_spaces > 0:
		return true
	return false
	


func fill_spaces():
	available_spaces = max_spaces
	texts = global_text.bingo_text.duplicate()
	
	for y in bingo_height:
		var hbox = HBoxContainer.new()
		$VBoxContainer.add_child(hbox)
	
		for x in bingo_lenght:
			var square = bingo_square.instantiate()
			
			if texts.is_empty():
				add_button()
				return
			
			if not enough_spaces():
				add_button()
				return
			
			var chosen_text = randi_range(0, texts.size() - 1) 
			
			
			if available_spaces == 13:
				square.set_text("Free space")
			else:
				square.set_text(texts[chosen_text])
				texts.remove_at(chosen_text)
			
			hbox.add_child(square)
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

