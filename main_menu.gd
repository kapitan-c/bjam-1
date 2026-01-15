extends Control

@onready var button: Button = %Button
const LEVEL_1 = preload("uid://ulrsa7s6ct7q")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.connect("pressed", load_first_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_first_level() -> void:
	get_tree().change_scene_to_packed(LEVEL_1)
