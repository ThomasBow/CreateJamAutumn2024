extends Node2D

var is_occupied: bool = false  # Tracks if the table is occupied
var customer: Node = null  # Reference to the customer at the table (if any)

# Mark the table as occupied and assign a customer to it
func occupy_table(customer_node: Node):
	is_occupied = true
	customer = customer_node

# Mark the table as free when the customer leaves
func free_table():
	is_occupied = false
	customer = null

# Return the position of the specified chair (either "left" or "right")
func get_seat_position(side: String) -> Vector2:
	return $ChairLeft.position if side == "left" else $ChairRight.position
