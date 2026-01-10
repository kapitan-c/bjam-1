extends CharacterBody2D

const TILE_SIZE = 64

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
	move_and_collide(direction*TILE_SIZE)
