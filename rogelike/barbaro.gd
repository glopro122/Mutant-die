extends RigidBody2D

@export var velocidad_maxima: float = 150
@export var fuerza_persecucion: float = 100
@export var fuerza_errante: float = 3
var jugador: Node2D
var direccion_errante: Vector2 = Vector2.ZERO
var tiempo_cambio_direccion: float = 2.0

func _ready():
	jugador = get_tree().get_first_node_in_group("jugador")
	gravity_scale = 0
	linear_damp = 1.2  # Aumentado para menos rebote
	mass = 0.3  # Masa reducida para ser más fácil de empujar
	
	# Configurar capas de colisión
	set_collision_layer_value(2, true)   # Este enemigo está en capa 2
	set_collision_mask_value(1, false)   # No colisionar físicamente con jugador
	set_collision_mask_value(3, true)    # Sí colisionar con paredes/obstáculos
	
	_cambiar_direccion_errante()

func _physics_process(delta):
	if not jugador:
		return
	
	# Fuerza hacia el jugador (pero sin colisión física)
	var direccion_jugador = (jugador.global_position - global_position).normalized()
	var fuerza_total = direccion_jugador * fuerza_persecucion
	
	# Fuerza errante para movimiento orgánico
	fuerza_total += direccion_errante * fuerza_errante
	
	apply_central_force(fuerza_total * 100 * delta)
	
	# Limitar velocidad máxima
	if linear_velocity.length() > velocidad_maxima:
		linear_velocity = linear_velocity.normalized() * velocidad_maxima
	
	# Cambiar dirección errante periódicamente
	tiempo_cambio_direccion -= delta
	if tiempo_cambio_direccion <= 0:
		_cambiar_direccion_errante()
		tiempo_cambio_direccion = randf_range(1.5, 3.0)

func _cambiar_direccion_errante():
	direccion_errante = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func _integrate_forces(state):
	# Suavizar colisiones con el jugador
	for i in range(state.get_contact_count()):
		var collider = state.get_contact_collider_object(i)
		if collider and collider.is_in_group("jugador"):
			var normal = state.get_contact_local_normal(i)
			state.apply_impulse(-normal * state.get_contact_impulse(i) * 0.05)  # Muy poca reacción
func _on_area_2d_area_entered(area: Area2D) -> void:
	if player != null:
		velocity = position.direction_to(player.position) * -velocidad_maxima
		move_and_slide()
