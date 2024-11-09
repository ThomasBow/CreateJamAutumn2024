extends Timer

@export var spawn_interval: float = 5.0  # Interval between spawns

# You can call this function from the GameController when it's time to spawn
func start_timer():
	start(spawn_interval)  # Start the timer with the spawn interval

func _on_timeout():
	# Call the function in GameController to spawn a new customer
	emit_signal("spawn_customer")  # You can signal the controller to spawn the customer
