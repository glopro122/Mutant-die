extends Sprite2D


var bullet = preload("res://bala.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
	look_at(get_global_mouse_position())

func shoot():
	var newBullet = bullet.instantiate()
	newBullet.direction = rotation
	newBullet.global_position = $".".get_global_mouse_position()
	get_parent().add_child(newBullet)
