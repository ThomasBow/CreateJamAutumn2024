extends Node2D

var is_occupied: bool = true  # Tracks if the table is occupied
var customer: Node = null  # Reference to the customer at the table (if any)

# Mark the table as occupied and assign a customer to it
func occupy_table(customer_node: Node):
	is_occupied = true
	customer = customer_node

# Mark the table as free when the customer leaves
func free_table():
	is_occupied = false
	customer = null
