extends CharacterBody2D
class_name Enemy

var speed = 100
var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = $"../personaje"
	var player = get_tree().get_first_node_in_group("jugador")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null:
		velocity = position.direction_to(player.position) * speed
		move_and_slide()





func _on_area_2d_area_entered(area: Area2D) -> void:
	if player != null:
		velocity = position.direction_to(player.position) * -speed *2
		move_and_slide()
		print("Detectado arañad")
