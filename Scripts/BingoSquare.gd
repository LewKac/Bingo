extends MarginContainer

var current_state : bool = false
@onready var colorRect = $ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.tile_change.connect(new_state)

func set_text(bingo_text : String) -> void:
	$MarginContainer/Label.text = bingo_text
	return

func new_state(state : bool): 
	current_state = state
