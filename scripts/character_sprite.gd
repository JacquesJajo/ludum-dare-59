extends AnimatedSprite2D

class_name CharacterSprite

enum State {
	IDLE,
	MOVING
}

signal move_complete

@export var face_centre: bool = true
@export var hold_spot: Node2D
var original_hold_spot: Vector2

var state: State = State.IDLE

var target: Vector2
var speed: float

func _ready() -> void:
	if hold_spot != null:
		original_hold_spot = hold_spot.position

func _process(delta: float) -> void:
	if position.x > 0.0 and face_centre:
		flip_h = true
		if hold_spot != null:
			hold_spot.position = Vector2(-original_hold_spot.x, original_hold_spot.y)
	else:
		flip_h = false
		if hold_spot != null:
			hold_spot.position = original_hold_spot
	
	match state:
		State.IDLE:
			pass
			
		State.MOVING:
			self.global_position = self.global_position.move_toward(target, speed * delta)
			
			if (self.global_position - self.target).is_zero_approx():
				move_complete.emit()
				state = State.IDLE

func move_sprite(target: Vector2, speed: float):
	self.target = target
	self.speed = speed

	state = State.MOVING

func get_hold_spot() -> Vector2:
	if hold_spot == null:
		return self.global_position
	return hold_spot.global_position
