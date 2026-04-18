extends Node2D

class_name BaseManager

var bases: Array[Vector2]

func build_list() -> void:
	for child in get_children():
		bases.append(child.position)
