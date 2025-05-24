extends CharacterBody2D
class_name enemy
var is_enemy = true
var speed = 50
var player = null

func _ready() -> void:
	# Buscar cualquier jugador en la escena (sin importar cuál)
	var jugadores = get_tree().get_nodes_in_group("jugador")
	if jugadores.size() > 0:
		player = jugadores[0]  # Toma el primer jugador que encuentre

func _physics_process(delta: float) -> void:
	if player != null:
		velocity = position.direction_to(player.position) * speed
		move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("jugador"):  # Verifica si es un jugador
		velocity = velocity * -1  # Simple retroceso
		move_and_slide()
		print("Chocó con jugador")
		




func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		if "is_bullet" in body:
			print("Entro bala")
			$Salud2.recibir_daño(25)
			body.queue_free()
