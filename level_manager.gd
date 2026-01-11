extends Node2D

@onready var map: Node2D = %Map
@onready var player: CharacterBody2D = %Player
var number_of_player_moves := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect("player_moved", _on_player_moved)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_moved(player_position) -> void:
	number_of_player_moves += 1
	var internal_number_of_player_moves = number_of_player_moves
	var tile_map_cell = map.local_to_map(player_position/4 )
	var tile_map_cell_data = map.get_cell_tile_data(tile_map_cell)
	var is_hole = tile_map_cell_data.get_custom_data("is_hole")
	if is_hole:
		player.die()
	else:
		#change the cell the player is standing on to a different color
		#then change it to a hole
		map.set_cell(tile_map_cell, 0, Vector2i(9,6))
		await get_tree().create_timer(1.25).timeout
		map.set_cell(tile_map_cell, 0, Vector2i(8,7))
		#if the player has not moved, fall in the hole, as determined by a counter
		if internal_number_of_player_moves == number_of_player_moves:
			player.die()
		
		
