extends Node2D

@onready var map: Node2D = %Map
@onready var player: CharacterBody2D = %Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect("player_moved", _on_player_moved)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_moved(player_position) -> void:
	var tile_map_cell = map.local_to_map(player_position/4 )
	var tile_map_cell_data = map.get_cell_tile_data(tile_map_cell)
	var is_hole = tile_map_cell_data.get_custom_data("is_hole")
	if is_hole:
		player.die()
