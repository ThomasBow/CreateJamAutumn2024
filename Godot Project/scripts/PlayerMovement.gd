extends CharacterBody2D

class_name PlayerMovement

@export var speed: int = 300
@export var tile_map_layer_parent_node: Node2D
@export var buttons: Array = ["ui_left", "ui_right", "ui_up", "ui_down", "enter", "backspace"] 
@export var highlightIDthing = 0
var tile_map_layers: Array = []
var _animated_sprite_2d: AnimatedSprite2D

enum Direction { UP, DOWN, LEFT, RIGHT }
var lastDirection: Direction = Direction.LEFT

var newestNeighboringCells: Array = []

var newestHighlightedTileCoords: Vector2i = Vector2i(-10000, -10000)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animated_sprite_2d = $AnimatedSprite2D
	get_tile_map_layers()




func GetGlobalPositio() -> Vector2:
	var position = global_position
	position.x -= 5
	position.y += 8
	return position




func get_tile_map_layers() -> void:
	if tile_map_layer_parent_node == null:
		return
	
	tile_map_layers = []
	for child in tile_map_layer_parent_node.get_children():
		if child is TileMapLayer:
			tile_map_layers.append(child)




# Function to get the tile(s) the player is currently standing on
func get_current_tiles_from_position() -> Array:
	var playerPosition = GetGlobalPositio()
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




func GetNeighboringCellInWalkingDirection(player_position: Vector2, layer: TileMapLayer, direction: Direction) -> TileData:
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
	var direction_vector: Vector2 = Input.get_vector(buttons[0], buttons[1], buttons[2], buttons[3])
	
	SetDirection(direction_vector)
	
	# Flip the sprite based on direction
	if direction_vector.x < 0:
		_animated_sprite_2d.scale = Vector2(1, 1)
	elif direction_vector.x > 0:
		_animated_sprite_2d.scale = Vector2(-1, 1)
	
	# Calculate movement vector
	velocity = direction_vector * speed




func SetDirection(directionVector: Vector2):
	if directionVector.x > 0:
		lastDirection = Direction.RIGHT
	elif directionVector.x < 0:
		lastDirection = Direction.LEFT
	elif directionVector.y < 0:
		lastDirection = Direction.UP
	elif directionVector.y > 0:
		lastDirection = Direction.DOWN




func GetLayerWithName(layerName: String) -> TileMapLayer:
	for layer in tile_map_layers:
		if layer.name == layerName:
			return layer 
	return null




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	calculate_movement() # This function uses delta itself
	move_and_slide()
	
	HighlightNeibhoringCellInWalkingDirection()
	GetNeighboringCellsInWalkingDirection()





func GetNeighboringCellsInWalkingDirection() -> Array:
	var neighboringCells: Array = []
	for layer in tile_map_layers:
		var cell: TileData = GetNeighboringCellInWalkingDirection(GetGlobalPositio(), layer, lastDirection)
		neighboringCells.append(cell)
	
	newestNeighboringCells = neighboringCells
	return neighboringCells




func HighlightNeibhoringCellInWalkingDirection() -> void:
	var highlightingLayer: TileMapLayer = GetLayerWithName("HighlightLayer")
	if highlightingLayer == null:
		return
	
	var tileCoords = highlightingLayer.local_to_map(GetGlobalPositio())
	var neighbor_coords = tileCoords
	
	# Adjust the coordinates based on direction
	match lastDirection:
		Direction.UP:
			neighbor_coords.y -= 1  # Move up in the grid
		Direction.DOWN:
			neighbor_coords.y += 1  # Move down in the grid
		Direction.LEFT:
			neighbor_coords.x -= 1  # Move left in the grid
		Direction.RIGHT:
			neighbor_coords.x += 1  # Move right in the grid
	
	if neighbor_coords != newestHighlightedTileCoords:
		highlightingLayer.erase_cell(newestHighlightedTileCoords)
		
		var sourceId: int = highlightIDthing
		var atlasCoords: Vector2i = Vector2i(0,0)
		
		highlightingLayer.set_cell(neighbor_coords, sourceId, atlasCoords)
		
		newestHighlightedTileCoords = neighbor_coords
	
