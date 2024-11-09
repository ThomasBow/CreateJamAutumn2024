extends Node2D

@export var left: Node2D  # Position of the left chair
@export var right: Node2D  # Position of the right chair

@export var available_sides := ["left", "right"]  # Only left and right chairs
@export var customer_scene: PackedScene  # The customer sprite to spawn

func _ready():
	# Spawn customers at the left and right chair positions
	spawn_customers()

func spawn_customers():
	# Iterate through available sides (left and right)
	for side in available_sides:
		var spawn_position: Vector2

		# Determine the spawn position based on which side we're using
		if side == "left" and left:
			spawn_position = left.position
		elif side == "right" and right:
			spawn_position = right.position
		else:
			continue
		
		# Spawn the customer sprite off-screen (e.g., at position (-1, 1))
		var customer = customer_scene.instantiate()
		customer.position = Vector2(-1, 1)  # Starting position off-screen

		# Add the customer to the scene
		add_child(customer)

		# Move the customer to the correct chair position (left or right)
		move_customer_to_position(customer, spawn_position)

func move_customer_to_position(customer: Node2D, target_position: Vector2):
	# Use a Tween for smooth movement to the target position (left or right)
	var move_duration = 1.5  # Time it will take to move the customer to the chair position
	var tween = customer.get_node("Tween")  # Look for a Tween node in the customer scene
	if tween == null:
		# If no tween exists, create and add one
		tween = Tween.new()
		customer.add_child(tween)

	# Animate the movement of the customer to the target position (chair)
	tween.tween_property(customer, "position", target_position, move_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
