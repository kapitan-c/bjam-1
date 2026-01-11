extends CharacterBody2D

const TILE_SIZE = 64
@onready var animation_player: AnimationPlayer = %AnimationPlayer

@onready var area_2d: Area2D = %Area2D
signal player_moved
var player_has_key := false
var start_position: Vector2
var player_is_dead := false
var player_can_move := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.connect("area_entered", _on_area_2d_entered)
	start_position = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !player_is_dead:
		if Input.is_action_just_pressed("move_up"):
			move_player(Vector2.UP)
		if Input.is_action_just_pressed("move_down"):
			move_player(Vector2.DOWN)
		if Input.is_action_just_pressed("move_left"):
			move_player(Vector2.LEFT)
		if Input.is_action_just_pressed("move_right"):
			move_player(Vector2.RIGHT)

func move_player(direction: Vector2) -> void:
	if player_can_move:
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
		emit_signal("player_moved", global_position)
		player_can_move = false
		await get_tree().create_timer(0.25).timeout
		player_can_move = true


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

func die() -> void:
	player_is_dead = true
	animation_player.play("player_falls")
	await animation_player.animation_finished
	get_tree().reload_current_scene()
