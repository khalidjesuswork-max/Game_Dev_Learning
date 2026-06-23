extends Area2D

const Hit_Strength	= 5
const Hit_Fade		= 0.1
const Hit_Y_Strength = -100

@onready var timer: Timer = $Timer

var Hitted : float = 0
var Hit_Y : float = 0

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		Hitted = Hit_Strength;
		Hit_Y = Hit_Y_Strength;
		timer.start()

func _on_timer_timeout() -> void:
	Hitted = Hitted - Hit_Fade*Hit_Strength
	if Hitted >= 0:
		timer.start()
	else:
		Hitted = 0
		Hit_Y = 0

	print(Hitted)
