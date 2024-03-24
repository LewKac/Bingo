extends Control

@onready var TileText = $TileTexts
@onready var CurrentPrompts = $CurrentPrompts

func _process(delta):
	CurrentPrompts.text = "Current amount of prompts: %d" % len(TileText.text.split("\n", false))

func _ready():
	if not Globals.custom_bingo_text.is_empty():
		var old_text : String = "\n".join(Globals.custom_bingo_text)
		TileText.text = old_text

#Checks if the inserted list is long enough
func check_if_long_enough(texts : Array) -> bool:
	if len(texts) < 25:
		var error_menu = load("res://Scenes/error_window.tscn")
		var error_window = error_menu.instantiate()
		get_parent().add_child(error_window)
		error_window.not_enough_tiles(len(texts))
		return true
	return false


func check_if_correct_text(promptArray : Array) -> bool :
	if not (check_if_long_enough(promptArray)):
		return true
	
	return false




func _on_confirm_pressed():
	var promptArray = TileText.text.split("\n", false)
	if not check_if_correct_text(promptArray):
		return
	
	Globals.custom_bingo_text = promptArray
	Globals.custom_board = true
	get_tree().change_scene_to_file("res://Scenes/BingoBoard.tscn") 


func _on_cancel_pressed():
	get_tree().change_scene_to_file("res://Scenes/selection.tscn") 


func _on_tutorial_pressed():
	var tutorial_menu = load("res://Scenes/tutorial_window.tscn")
	var tutorial_window = tutorial_menu.instantiate()
	get_parent().add_child(tutorial_window)
