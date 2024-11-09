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




func cook() -> void:
	self.texture = cookedTexture
	cooked = true




func can_be_cooked(cooktype: Appliance.CookingType) -> bool:
	return cooktype == cookingType
