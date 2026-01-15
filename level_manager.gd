extends Node2D

@onready var map:= %Map
@onready var player: CharacterBody2D = %Player
@onready var level_complete_screen: CanvasLayer = %LevelCompleteScreen
var screen_scale_amount := 3
var level_complete := false




var number_of_player_moves := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect("player_moved", _on_player_moved)
	player.connect("level_complete", _on_level_complete)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if level_complete:
		if Input.is_action_just_pressed("continue"):
			continue_to_next_level()

func _on_player_moved(player_position) -> void:
	number_of_player_moves += 1
	var internal_number_of_player_moves = number_of_player_moves
	var tile_map_cell = map.local_to_map(player_position/screen_scale_amount )
	var tile_map_cell_data = map.get_cell_tile_data(tile_map_cell)
	var is_hole = tile_map_cell_data.get_custom_data("is_hole")
	var is_trapdoor = tile_map_cell_data.get_custom_data("is_trapdoor")
	if is_hole:
		player.die()
	elif is_trapdoor:
		map.set_cell(tile_map_cell, 0, Vector2i(9,6))
		await get_tree().create_timer(1.25).timeout
		map.set_cell(tile_map_cell, 0, Vector2i(8,7))
		#if the player has not moved, fall in the hole, as determined by a counter
		if internal_number_of_player_moves == number_of_player_moves:
			player.die()
		await get_tree().create_timer(1.25).timeout
		map.set_cell(tile_map_cell, 0, Vector2i(8,3))
	else:
		#change the cell the player is standing on to a different color
		#then change it to a hole
		map.set_cell(tile_map_cell, 0, Vector2i(9,6))
		await get_tree().create_timer(1.25).timeout
		map.set_cell(tile_map_cell, 0, Vector2i(8,7))
		#if the player has not moved, fall in the hole, as determined by a counter
		if internal_number_of_player_moves == number_of_player_moves:
			player.die()
		
		
func _on_level_complete() -> void:
	level_complete_screen.show()
	GlobalVariables.level_id += 1
	level_complete = true
	get_tree().paused = true

func continue_to_next_level() -> void:
	var next_level = load("res://levels/level_" + str(GlobalVariables.level_id) + ".tscn")
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)

func restart_level() -> void:
	var current_level = load("res://levels/level_" + str(GlobalVariables.level_id) + ".tscn")
	get_tree().change_scene_to_packed(current_level)
