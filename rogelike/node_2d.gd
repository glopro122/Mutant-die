extends Node2D

@export var escena_enemigo: PackedScene
@export var radio_generacion: float = 300
@export var intervalo_generacion: float = 2.5
@export var distancia_al_jugador: float = 180
@export var velocidad_seguimiento: float = 2.0

var jugador: Node2D
var angulo_actual: float = 0.0

func _ready():
	# Conexión manual de la señal timeout si no está conectada en el editor
	$Timer.timeout.connect(_on_timer_timeout)
	
	# Buscar jugador con verificación de error
	jugador = get_tree().get_first_node_in_group("jugador")
	if not jugador:
		push_error("Error: No se encontró el nodo del jugador (asegúrate de que tiene el grupo 'jugador')")
		return
	
	# Configuración del timer
	$Timer.wait_time = intervalo_generacion
	$Timer.start()
	print("Generador iniciado correctamente")  # Mensaje de depuración
	
	# Inicialización
	angulo_actual = randf_range(0, TAU)
	_actualizar_posicion()

func _process(delta):
	if jugador:
		angulo_actual += randf_range(-0.1, 0.1)
		_actualizar_posicion()

func _actualizar_posicion():
	var offset = Vector2(cos(angulo_actual), sin(angulo_actual)) * distancia_al_jugador
	global_position = jugador.global_position + offset

func _on_timer_timeout():
	if not escena_enemigo:
		push_error("Error: No hay escena de enemigo asignada en el generador")
		return
	
	if not is_inside_tree():
		push_error("Error: El generador no está en el árbol de escena")
		return
	
	# Crear enemigo
	var enemigo = escena_enemigo.instantiate()
	
	# Posición aleatoria en círculo
	var angulo = randf_range(0, TAU)
	var distancia = randf_range(50, radio_generacion)
	var posicion = global_position + Vector2(cos(angulo), sin(angulo)) * distancia
	
	# Añadir a la escena
	get_parent().add_child(enemigo)
	enemigo.global_position = posicion
	
	print("Enemigo generado en: ", posicion)  # Depuración
