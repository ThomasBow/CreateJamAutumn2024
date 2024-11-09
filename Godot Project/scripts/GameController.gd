extends Node2D

@export var customer_scene: PackedScene  # Customer sprite scene to spawn
@export var max_customers: int = 4  # Maximum number of customers at once
@export var spawn_interval: float = 5.0  # Time interval between customer spawns
var occupied_tables: Array = []  # List to track occupied tables
var time_since_last_spawn: float = 0.0  # Timer to track the spawn interval
var tables: Array = [$Table1,$Table2,$Table3,$Table4]  # Declare tables array to hold references

func _ready():
	# Print the number of tables
	print("Number of tables in the array: ", tables.size())

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

		# Print out a message indicating a customer has been spawned
		print("Customer spawned at table ", available_table.name, " on side ", side)
	else:
		print("No available tables to spawn a new customer.")
