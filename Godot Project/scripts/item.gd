extends Node2D

class_name Item

@export var itemName: String = "Undefined"
@export var itemUUID: String = "Undefined"
@export var process_time: float = 5
@export var uncookedTexture: Texture
@export var cookedTexture: Texture

@export var cookingType: Appliance.CookingType

@export var sprite: Sprite2D

var cooked: bool = false

func _ready() -> void:
	sprite.texture = uncookedTexture




func cook() -> void:
	sprite.texture = cookedTexture
	cooked = true




func can_be_cooked(cooktype: Appliance.CookingType) -> bool:
	return cooktype == cookingType
