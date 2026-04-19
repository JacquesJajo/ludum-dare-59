extends Node2D

class_name Explosion

const PIXEL_RADIUS: float = 16.0

var max_radius: float = 5.0
var radius: float = 1.0

func _process(delta: float) -> void:
	radius += 2.0 * delta
	if radius > max_radius:
		radius = max_radius
	self.scale = Vector2(radius, radius)

func get_pixel_radius() -> float:
	return scale.x * PIXEL_RADIUS
