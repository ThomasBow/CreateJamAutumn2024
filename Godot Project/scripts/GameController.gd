extends Node2D

@export var customer_scene: PackedScene  # Customer sprite scene to spawn
@export var max_customers: int = 4  # Maximum number of customers at once
@export var spawn_interval: float = 5.0  # Time interval between customer spawns
var occupied_tables: Array = []  # List to track occupied tables
var time_since_last_spawn: float = 0.0  # Timer to track the spawn interval
var tables: Array = [$Table1,$Table2,$Table3,$Table4]  # Declare tables array to hold references

func _ready():
	tables = []  # Clear the tables array

	# Loop through each child of GameController to check if it's a Table instance
	for child in get_children():
		# Check if the child node has the Table.gd script attached
		if child.get_script() == preload("res://scripts/Table.gd"):  # Update to your Table.gd path
			tables.append(child)

	# Debug output to verify the tables were added correctly
	print("Number of tables found: ", tables.size())
	for table in tables:
		print("Table ", table.name, " - Occupied: ", table.is_occupied)

	# Start processing the customer spawn logic
	set_process(true)

func _process(delta):
	# Increment the time since the last spawn attempt
	time_since_last_spawn += delta

	# If the time since the last spawn exceeds the interval, try to spawn a customer
	if time_since_last_spawn >= spawn_interval:
		time_since_last_spawn = 0.0  # Reset the timer
		spawn_customer()

func spawn_customer():
	var available_table = null
	for table in tables:
		if table != null:
			print("Checking table ", table.name, " - Occupied: ", table.is_occupied)
			if not table.is_occupied:
				available_table = table
				break

	if available_table:
		var side = "left" if randi() % 2 == 0 else "right"
		var spawn_position = available_table.get_seat_position(side)
		var customer = customer_scene.instantiate()
		customer.position = Vector2(-1, 1)
		add_child(customer)

		#customer.target_position = spawn_position
		#customer.table_node = available_table

		available_table.occupy_table(customer)
		print("Customer spawned at table ", available_table.name, " on side ", side)
	else:
		print("No available tables to spawn a new customer.")
