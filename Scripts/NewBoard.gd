extends Control

@onready var TileText = $TileTexts


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func check_if_correct_text():
	print(TileText.text.split("\n", false))

func _on_confirm_pressed():
	check_if_correct_text()
	pass # Replace with function body.


func _on_cancel_pressed():
	pass # Replace with function body.


func _on_tutorial_pressed():
	pass # Replace with function body.
