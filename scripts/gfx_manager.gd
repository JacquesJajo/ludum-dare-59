extends Node2D

class_name GFXManager

var sprites: Array[AnimatedSprite2D]

func build_list() -> void:
	for child in get_children():
		if child is AnimatedSprite2D:
			sprites.append(child)
