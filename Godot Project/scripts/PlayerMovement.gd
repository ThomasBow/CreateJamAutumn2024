extends CharacterBody2D

@export var speed: int = 300
@export var tile_map_layer_parent_node: Node2D

var tile_map_layers: Array = []
var _animated_sprite_2d: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animated_sprite_2d = $AnimatedSprite2D
	get_tile_map_layers()

func get_tile_map_layers() -> void:
	tile_map_layers = []
	for child in tile_map_layer_parent_node.get_children():
		if child is TileMapLayer:
			tile_map_layers.append(child)

func calculate_movement() -> void:
	# Get direction
	var direction_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Flip the sprite based on direction
	if direction_vector.x < 0:
		_animated_sprite_2d.scale = Vector2(1, 1)
	elif direction_vector.x > 0:
		_animated_sprite_2d.scale = Vector2(-1, 1)
	
	# Calculate movement vector
	velocity = direction_vector * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	calculate_movement() # This function uses delta itself
	move_and_slide()
