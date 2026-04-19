extends AnimatedSprite2D

class_name CharacterSprite

enum State {
	IDLE,
	MOVING
}

signal move_complete

@export var face_centre: bool = true

var state: State = State.IDLE

var target: Vector2
var speed: float

func _process(delta: float) -> void:
	if position.x > 0.0 and face_centre:
		flip_h = true
	else:
		flip_h = false
	
	match state:
		State.IDLE:
			pass
			
		State.MOVING:
			self.position = self.position.move_toward(target, speed * delta)
			
			if (self.position - self.target).is_zero_approx():
				move_complete.emit()
				state = State.IDLE

func move_sprite(target: Vector2, speed: float):
	self.target = target
	self.speed = speed

	state = State.MOVING
