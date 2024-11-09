extends Node



var items: Array


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GetItemsOnReady()




func GetItemsOnReady() -> void:
	for child in get_children():
		if child is Item:
			items.append(child)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
