extends Item

class_name Body

func _init():
	self.itemName = "Dead body";
	self.process_time = 10;
	self.uncookedTexture = load("res://sprites/dead_body.png");
	self.texture = load("res://sprites/dead_body.png");

func can_be_cooked(cooking_type: Appliance.CookingType):
	return cooking_type == Appliance.CookingType.CHOP

static func _make_ingredient(name: String, processing_time: float, cooking_type: Appliance.CookingType) -> Item:
	return Item.create(name, name, processing_time, load("res://sprites/ingredient_" + name + ".png"), load("res://sprites/done_ingredient_" + name + ".png"), cooking_type)

func cook():
	var items: Dictionary = {
		"arm": _make_ingredient("arm", 5, Appliance.CookingType.CHOP),
		"brain": _make_ingredient("brain", 5, Appliance.CookingType.DEEP_FRY)
	}
	
	var i = 0
	for item in items:
		self.get_parent().add_child(item);
		item.position = self.position + Vector2(-1, -i);
		i+=1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.cook();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
