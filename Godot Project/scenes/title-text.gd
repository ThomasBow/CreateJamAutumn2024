extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize();

const chance_to_be_off: float = 0.05;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if randf()>chance_to_be_off:
		self.visible = true;
	else:
		self.visible = false;

func _input(event: InputEvent) -> void:
	if event is InputEventKey and (event as InputEventKey).get_keycode() == KEY_SPACE:
		get_tree().change_scene_to_file("res://scenes/Game.tscn")
