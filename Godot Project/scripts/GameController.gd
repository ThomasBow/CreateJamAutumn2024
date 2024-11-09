extends Node2D

@export var tables: Array  # List of all table nodes
@export var customer_scene: PackedScene  # Customer sprite scene to spawn
@export var max_customers: int = 4  # Maximum number of customers at once
var occupied_tables: Array = []  # List to track occupied tables

func _ready():
	# Initialize the customer spawning process
	set_process(true)

func _process(delta):
	# If there are fewer customers than the maximum, try to spawn new ones
	if occupied_tables.size() < max_customers:
		spawn_customer()

func spawn_customer():
	# Find the first unoccupied table
	var available_table = null
	for table in tables:
		if !occupied_tables.has(table):  # Check if the table is not occupied
			available_table = table
			break  # Found an unoccupied table

	# If we found an unoccupied table, spawn the customer
	if available_table:
		occupied_tables.append(available_table)  # Mark the table as occupied

		# Select the left or right side of the table for spawning
		var side = "left" if randi() % 2 == 0 else "right"
		var spawn_position = available_table.get_node(side).position

		# Instantiate the customer at the selected position
		var customer = customer_scene.instantiate()
		customer.position = Vector2(-1, 1)  # Start off-screen position
		add_child(customer)

		# Move the customer to the correct chair position
		var tween = customer.get_node("Tween")  # Find a Tween node in the customer scene
		if tween == null:
			tween = Tween.new()
			customer.add_child(tween)

		# Animate the customer's movement to the target position (chair)
		tween.tween_property(customer, "position", spawn_position, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
