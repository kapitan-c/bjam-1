extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func make_a_tile_fall(player_position) -> void:
	var tile_map_cell = local_to_map(player_position/4 )
	var tile_map_cell_data = get_cell_tile_data(tile_map_cell)
	tile_map_cell_data.set_custom_data("is_hole", true)
