extends Node2D

# Define movement properties
var target_position: Vector2
var current_position: Vector2
const GRID_SIZE = 16.0 # Grid size (e.g., 16x16 pixels)
const SPEED = 300.0 # Speed of the customer AI

# Reference to the TileMap for pathfinding
@export var tilemap: TileMap

# Set the initial target in _ready or through another script
func _ready():
	# Automatically detect and set the starting grid position
	current_position = (global_position / GRID_SIZE).floor()
	target_position = current_position
	position = current_position * GRID_SIZE # Snap to grid position initially

	# Optional: Set an example target to demonstrate movement
	set_target_position(Vector2(5, 5))

func _process(delta):
	move_to_target(delta)

func move_to_target(delta):
	# Move towards the target position if it’s not already there
	if position != target_position * GRID_SIZE:
		var direction = (target_position * GRID_SIZE - position).normalized()
		position += direction * SPEED * delta

		# Snap to the target when close enough to avoid overshooting
		if position.distance_to(target_position * GRID_SIZE) < 1.0:
			position = target_position * GRID_SIZE

# Sets a new target position if it’s walkable
func set_target_position(new_target: Vector2):
	if is_valid_position(new_target):
		target_position = new_target

# Checks if a tile in the TileMap is walkable
func is_valid_position(position: Vector2) -> bool:
	# Convert position to tilemap coordinates
	var tile_position = position.floor()
	var tile_id = tilemap.get_cellv(tile_position)

	# Assuming -1 means no tile (walkable space), adjust based on your tileset setup
	return tile_id == -1 # Returns true if walkable; adjust condition for your TileMap setup
