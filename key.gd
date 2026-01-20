extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#play a sound and disappear
func get_picked_up() -> void:
	sprite_2d.visible = false
	collision_shape_2d.set_deferred("disabled", true)
	audio_stream_player_2d.play()
	await audio_stream_player_2d.finished
	queue_free()
