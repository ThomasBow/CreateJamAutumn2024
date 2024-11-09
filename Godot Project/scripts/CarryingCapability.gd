extends Node2D

@export var currentItem: Item
var sprite_node: Sprite2D

func _ready():
	sprite_node = get_node("CarriedSprite") as Sprite2D
	
	update_current_item_texture()
	var voices = DisplayServer.tts_get_voices_for_language("en")
	var voice_id = voices[0]
	
	DisplayServer.tts_speak("Hello Thomas", voice_id)
	

func update_current_item_texture():
	if currentItem.cooked:
		sprite_node.texture = currentItem.cookedTexture
	else:
		sprite_node.texture = currentItem.uncookedTexture
	
