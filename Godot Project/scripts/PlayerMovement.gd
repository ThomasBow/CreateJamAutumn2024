extends CharacterBody2D

class_name PlayerMovement

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

# Function to get the tile(s) the player is currently standing on
func get_current_tiles_from_position()
	var player_position = global_position
	var layers_i = tile_map_layers.count() - 1
	for tile_map_layer_i in range(layers_i, 0, -1):
		var tile_map_layer = tile_map_layers[tile_map_layer_i]
		

# Function to get the tile from the given layer
func get_current_tile_from_layer(layer: TileMapLayer) -> TileData:
	var player_position = global_position
	var tile_coords = layer.local_to_map(layer.to_local(player_position))
	return layer.get_cell_tile_data(tile_coords)

func calculate_movement() -> void:
	# Get direction
	var direction_vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
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
	print(get_current_tile().terrain)
