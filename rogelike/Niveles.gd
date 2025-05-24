# SistemaNivelesCirculares.gd
extends Node
class_name SistemaNivelesCirculares

signal experiencia_actualizada(exp_actual, exp_siguiente_nivel)
signal nivel_subido(nuevo_nivel, mejoras_aplicadas)

class NodoNivel:
	var exp_necesaria: int
	var beneficios: Dictionary
	var siguiente: NodoNivel
	
	func _init(exp: int, beneficios: Dictionary):
		self.exp_necesaria = exp
		self.beneficios = beneficios
		self.siguiente = self  # Auto-referencia inicial

var cabeza: NodoNivel
var nivel_actual: NodoNivel
var contador_niveles: int = 1
var experiencia_actual: int = 0

func _ready():
	inicializar_niveles()

# Inicializa los primeros niveles (ejemplo: 3 niveles base)
func inicializar_niveles():
	cabeza = NodoNivel.new(100, {"vida": 10, "daño": 5})
	var nivel2 = NodoNivel.new(150, {"vida": 12, "daño": 6})
	var nivel3 = NodoNivel.new(225, {"vida": 14, "daño": 7})
	
	cabeza.siguiente = nivel2
	nivel2.siguiente = nivel3
	nivel3.siguiente = cabeza  # Hacemos la lista circular
	
	nivel_actual = cabeza

# Añade experiencia y verifica si sube de nivel
func ganar_experiencia(cantidad: int, jugador: Node):
	experiencia_actual += cantidad
	if experiencia_actual >= nivel_actual.exp_necesaria:
		experiencia_actual -= nivel_actual.exp_necesaria
		avanzar_nivel(jugador)

# Avanza al siguiente nivel y aplica mejoras
func avanzar_nivel(jugador: Node):
	nivel_actual = nivel_actual.siguiente
	contador_niveles += 1
	aplicar_mejoras(jugador)
	
	# Si volvemos al inicio, genera nuevos niveles más difíciles
	if nivel_actual == cabeza:
		generar_nuevos_niveles()
	
	# Evento personalizado (opcional, para UI/sonidos)
	emit_signal("nivel_subido", contador_niveles)

# Genera nuevos niveles con progresión exponencial
func generar_nuevos_niveles():
	var ultimo = cabeza
	while ultimo.siguiente != cabeza:
		ultimo = ultimo.siguiente
	
	var nuevo_exp = int(ultimo.exp_necesaria * 1.5)  # Aumento del 50%
	var nuevos_beneficios = {
		"vida": ultimo.beneficios["vida"] + 2,
		"daño": ultimo.beneficios["daño"] + 1
	}
	
	var nuevo_nivel = NodoNivel.new(nuevo_exp, nuevos_beneficios)
	ultimo.siguiente = nuevo_nivel
	nuevo_nivel.siguiente = cabeza  # Mantiene la circularidad

# Aplica mejoras al jugador
func aplicar_mejoras(jugador: Node):
	for beneficio in nivel_actual.beneficios:
		match beneficio:
			"vida":
				jugador.vida_maxima += nivel_actual.beneficios[beneficio]
				jugador.vida_actual = jugador.vida_maxima  # Cura al subir de nivel
			"daño":
				jugador.daño_base += nivel_actual.beneficios[beneficio]
	
	# Opcional: Mostrar mensaje de mejora en UI
	print("¡Nivel ", contador_niveles, "! Mejoras: ", nivel_actual.beneficios)

# Señales para comunicación con otros nodos
