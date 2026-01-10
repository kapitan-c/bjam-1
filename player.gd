extends CharacterBody2D

const TILE_SIZE = 64

@onready var area_2d: Area2D = %Area2D
var player_has_key := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.connect("area_entered", _on_area_2d_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		move_player(Vector2.UP)
	if Input.is_action_just_pressed("move_down"):
		move_player(Vector2.DOWN)
	if Input.is_action_just_pressed("move_left"):
		move_player(Vector2.LEFT)
	if Input.is_action_just_pressed("move_right"):
		move_player(Vector2.RIGHT)

func move_player(direction: Vector2) -> void:
	#position += direction * TILE_SIZE 
	var current_position = global_position
	var collison = move_and_collide(direction*TILE_SIZE)
	if collison:
		global_position = current_position
		var cell_position = global_position + (direction * TILE_SIZE)
		var tile_map = collison.get_collider()
		var tile_map_cell = tile_map.local_to_map(cell_position/4 )
		var tile_map_cell_data = tile_map.get_cell_tile_data(tile_map_cell)
		var custom_data = tile_map_cell_data.get_custom_data("is_door")
		if custom_data:
			try_to_open_door(tile_map_cell)
#use get_collider to detect what the player hits to open doors

func _on_area_2d_entered(area) -> void:
	if area.is_in_group("key"):
		player_has_key = true
		area.get_picked_up()
		
		
func try_to_open_door(door) -> void:
	if player_has_key:
		win()
	else:
		pass
		
func win() -> void:
	print("woot")
