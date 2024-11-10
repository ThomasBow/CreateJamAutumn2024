extends Sprite2D

class_name Item

@export var itemName: String = "Undefined"
@export var itemUUID: String = "Undefined"
@export var process_time: float = 5
@export var uncookedTexture: Texture
@export var cookedTexture: Texture

@export var cookingType: Appliance.CookingType

var cooked: bool = false

func _ready() -> void:
	self.texture = uncookedTexture

static func create(
		itemName: String, 
		itemUUID: String, 
		process_time: float, 
		uncookedTexture: Texture, 
		cookedTexture: Texture, 
		cookingType: Appliance.CookingType) -> Item:
	var item = Item.new();
	item.itemName = itemName;
	item.itemUUID = itemUUID;
	item.process_time = process_time;
	item.uncookedTexture = uncookedTexture;
	return item;


func cook() -> void:
	self.texture = cookedTexture
	cooked = true




func can_be_cooked(cooktype: Appliance.CookingType) -> bool:
	return cooktype == cookingType
