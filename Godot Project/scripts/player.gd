extends Node2D

@export var fleetness = 300 # Speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Input.get_vector("ui_left","ui_right","ui_up","ui_down") * fleetness * delta
