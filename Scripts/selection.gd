extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_to_scene_manually():
	get_tree().change_scene_to_file("res://Scenes/BingoBoard.tscn") 



func _on_raid_board_pressed():
	add_to_scene_manually()
