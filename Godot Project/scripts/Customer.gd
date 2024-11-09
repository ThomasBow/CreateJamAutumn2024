extends CharacterBody2D

@export var target_position: Vector2  # Target position (seat)
@export var movement_speed: float = 150.0  # Speed of customer movement
@export var table_node: Node2D  # The table where the customer sits

var is_seated: bool = false

func _ready():
	# Start moving towards the table
	move_to_target()

func _process(delta):
	# If the customer isn't seated, move towards the table
	if !is_seated:
		move_to_target()

# Moves the customer to the target position (table seat)
func move_to_target():
	if position.distance_to(target_position) > 5.0:  # Check if close enough
		var direction = (target_position - position).normalized()
		move_and_slide()
	else:
		# Once close enough, sit down at the table
		sit_at_table()

# Mark the customer as seated and stop movement
func sit_at_table():
	if !is_seated:
		is_seated = true
		table_node.occupy_table(self)  # Occupy the table (tell the table the customer is seated)
		print("Customer has sat at the table!")
