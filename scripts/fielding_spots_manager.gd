extends Node2D

class_name FieldingSpotsManager

var spots: Array[Vector2]

func build_list() -> void:
	for child in get_children():
		spots.append(child.position)
