extends CharacterBody2D

class_name PlayerMovement

@export var speed: int = 300
@export var tile_map_layer_parent_node: Node2D

var tile_map_layers: Array = []
var _animated_sprite_2d: AnimatedSprite2D

enum Direction { UP, DOWN, LEFT, RIGHT }
var lastDirection: Direction = Direction.LEFT

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
func get_current_tiles_from_position() -> Array:
	var playerPosition = global_position
	var tileDatas = []
	var layers_i = tile_map_layers.size() - 1
	for tile_map_layer_i in range(layers_i, -1, -1):
		var tile_map_layer: TileMapLayer = tile_map_layers[tile_map_layer_i]
		var tileData = get_current_tile_from_layer(playerPosition, tile_map_layer)
		if tileData != null:
			tileDatas.append(tileData)
	return tileDatas

# Function to get the tile from the given layer
func get_current_tile_from_layer(playerPosition: Vector2, layer: TileMapLayer) -> TileData:
	var tileCoords = layer.local_to_map(playerPosition)
	var tileData = layer.get_cell_tile_data(tileCoords)
	return tileData

func get_neighboring_tile(player_position: Vector2, layer: TileMapLayer, direction: Direction) -> TileData:
	var current_tile_coords = layer.local_to_map(player_position)
	var neighbor_coords = current_tile_coords
	
	# Adjust the coordinates based on direction
	match direction:
		Direction.UP:
			neighbor_coords.y -= 1  # Move up in the grid
		Direction.DOWN:
			neighbor_coords.y += 1  # Move down in the grid
		Direction.LEFT:
			neighbor_coords.x -= 1  # Move left in the grid
		Direction.RIGHT:
			neighbor_coords.x += 1  # Move right in the grid

	# Get tile data at the new coordinates
	var tile_data = layer.get_cell_tile_data(neighbor_coords)
	return tile_data

func calculate_movement() -> void:
	# Get direction
	var direction_vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction_vector.x > 0:
		lastDirection = Direction.RIGHT
	elif direction_vector.x < 0:
		lastDirection = Direction.LEFT
	elif direction_vector.y > 0:
		lastDirection = Direction.UP
	else:
		lastDirection = Direction.DOWN
	
	# Flip the sprite based on direction
	if direction_vector.x < 0:
		_animated_sprite_2d.scale = Vector2(1, 1)
	elif direction_vector.x > 0:
		_animated_sprite_2d.scale = Vector2(-1, 1)
	
	# Calculate movement vector
	velocity = direction_vector * speed

func GetLayerWithName(layerName: String) -> TileMapLayer:
	for layer in tile_map_layers:
		if layer.name == layerName:
			return layer 
	return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	calculate_movement() # This function uses delta itself
	move_and_slide()
	
	var highlightLayer = GetLayerWithName("HighlightLayer")
	get_neighboring_tile(global_position, highlightLayer, lastDirection)
	var tileDatas = get_current_tiles_from_position()
	print("----------------")
	if tileDatas.size() > 0:
		for tileData in tileDatas:
			print(tileData.to_string())
