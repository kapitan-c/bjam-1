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
	var collison = move_and_collide(direction*TILE_SIZE)
	if collison.get_collider().is_door:
		try_to_open_door(collison.get_collider())
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
