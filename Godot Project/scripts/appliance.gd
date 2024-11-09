extends Sprite2D

class_name Appliance

enum CookingType {FRY, DEEP_FRY, CHOP, PLATE}

@export var cooking_type: CookingType;
@export var error_sound: AudioStreamPlayer;

var item: Item = null;

var in_use: bool = false;
var time: float;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.in_use:
		self.time += delta;
		
		if self.time >= self.item.process_time:
			item.cook();
			
			
func place(item: Item):
	if item.can_be_cooked(cooking_type) and self.item==null:
		self.item = item;
	else:
		self.error_sound.play();
	
func remove() -> Item:
	var temp_item = self.item;
	self.item = null;
	return temp_item;


func start_using():
	if not self.in_use and self.item!=null:
		self.time = 0;
		self.in_use = true;
	
func stop_using():
	self.time = 0;
	self.in_use = false;
