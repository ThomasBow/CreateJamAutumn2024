extends Node2D

@export var tables: Array  # List of all table nodes
@export var customer_scene: PackedScene  # Customer sprite scene to spawn
@export var spawn_interval: float = 5.0  # Interval to spawn customers
@export var max_customers: int = 5  # Maximum number of customers in the game at once
var occupied_tables: Array = []  # List to track occupied tables
var customers_spawned: int = 0  # Track the number of customers spawned

func _ready():
	# Start the timer to spawn customers at intervals
	set_process(true)

# Called every frame (interval-based logic can be added here)
func _process(delta):
	# If we haven't reached the max customers and the interval has passed, spawn a new customer
	if customers_spawned < max_customers:
		if spawn_interval <= 0:
			spawn_customer()
			spawn_interval = 5.0  # Reset interval, adjust as needed
		else:
			spawn_interval -= delta  # Decrease the interval until the next spawn
	else:
		print("Max customers reached, not spawning more.")

# Spawns a customer at an available table
func spawn_customer():
	# Find the first unoccupied table
	var available_table = null
	for table in tables:
		if !occupied_tables.has(table):  # Check if the table is not occupied
			available_table = table
			break  # Found an unoccupied table, no need to check further

	# If we found an unoccupied table, spawn the customer
	if available_table:
		occupied_tables.append(available_table)  # Mark this table as occupied
		customers_spawned += 1  # Increment the number of spawned customers

		# Spawn the customer at this table
		var customer = customer_scene.instantiate()
		customer.position = available_table.position  # Position at the table (or any spawn point)
		add_child(customer)

		# Optional: Set an animation or other properties for the customer
		# Set the customer target to the table seat position if needed

		print("Customer spawned at table ", available_table.name)
	else:
		print("No available tables for a new customer.")
