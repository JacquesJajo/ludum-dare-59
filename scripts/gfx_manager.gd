extends Node2D

class_name GFXManager

var sprites: Array[Sprite2D]

func _ready() -> void:
	for child in get_children():
		if child is Sprite2D:
			sprites.append(child)
