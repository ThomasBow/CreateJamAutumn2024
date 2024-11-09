extends Node2D

@export var top: Node2D  # Export individual nodes for each spawn point
@export var bottom: Node2D
@export var left: Node2D
@export var right: Node2D

@export var available_sides := ["right", "bottom"]  # Modify per table instance
@export var customer_scene: PackedScene

func _ready():
	spawn_sprites()

func spawn_sprites():
	var first_side = true

	# Iterate through available sides and spawn customers
	for side in available_sides:
		var spawn_position: Vector2

		# Check which side we are using
		if side == "top" and top:
			spawn_position = top.position  # Use the position property of the node
		elif side == "bottom" and bottom:
			spawn_position = bottom.position
		elif side == "left" and left:
			spawn_position = left.position
		elif side == "right" and right:
			spawn_position = right.position
		else:
			continue

		# Spawn on the first side with 100% chance, then 50% for others
		if first_side or randi() % 2 == 0:
			var customer = customer_scene.instantiate()
			customer.position = spawn_position
			add_child(customer)
			first_side = false
