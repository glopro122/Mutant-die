extends CharacterBody2D

var is_bullet = true
var direction: float =  0.0
var Speed: float =  1000.0

func _ready() -> void:
	rotation = direction
	
func _physics_process(delta: float) -> void:
	velocity = Vector2 (Speed,0).rotated(direction)
	move_and_slide()
