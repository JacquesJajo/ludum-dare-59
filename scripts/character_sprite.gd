extends Sprite2D

class_name CharacterSprite

enum State {
	IDLE,
	MOVING
}

signal move_complete

var state: State = State.IDLE

var target: Vector2
var speed: float

func _process(delta: float) -> void:
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
