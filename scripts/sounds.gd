extends Node2D

class_name SoundManager

func get_explosion() -> AudioStreamPlayer:
	return $Explosion
	
func get_hit_ball() -> AudioStreamPlayer:
	return $HitBall
	
func get_hurt() -> AudioStreamPlayer:
	return $Hurt

func get_throw_ball() -> AudioStreamPlayer:
	return $ThrowBall
	
func get_victory() -> AudioStreamPlayer:
	return $Victory
	
func get_defeat() -> AudioStreamPlayer:
	return $Defeat
