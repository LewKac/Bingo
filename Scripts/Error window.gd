extends Control

@onready var message = $PanelContainer/ErrorMessage

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func not_enough_tiles(num : int):
	message.text = ("Not enough prompts inserted\nYou need at least 25 prompts.\nCurrently there are %d of prompts." % num)

func _on_exit_error_pressed():
	queue_free()
