extends Node
class_name SistemaNivelesCirculares

class NodoNivel:
	var exp_necesaria: int
	var beneficios: Dictionary
	var siguiente: NodoNivel
	
	func _init(exp: int, beneficios: Dictionary):
		self.exp_necesaria = exp
		self.beneficios = beneficios
		self.siguiente = self  # Circular por defecto (apunta a sí mismo)

var cabeza: NodoNivel
var nivel_actual: NodoNivel
var contador_niveles: int = 1

func _ready():
	# Crear lista circular de niveles
	inicializar_niveles()
	_imprimir_estructura()

func inicializar_niveles():
	# Primer nivel
	cabeza = NodoNivel.new(100, {"vida": 10, "daño": 5})
	nivel_actual = cabeza
	
	# Crear 2 niveles adicionales para demostración
	var nivel2 = NodoNivel.new(150, {"vida": 12, "daño": 6})
	var nivel3 = NodoNivel.new(225, {"vida": 14, "daño": 7})
	
	# Enlazar circularmente
	cabeza.siguiente = nivel2
	nivel2.siguiente = nivel3
	nivel3.siguiente = cabeza  # Hacemos circular la lista

func avanzar_nivel(jugador: Node):
	nivel_actual = nivel_actual.siguiente  # Avanza al siguiente (circular)
	contador_niveles += 1
	aplicar_mejoras(jugador)
	
	# Si volvemos al inicio, generamos nuevos niveles
	if nivel_actual == cabeza:
		generar_nuevos_niveles()
	
	_imprimir_estructura()

func generar_nuevos_niveles():
	var nuevo_exp = int(nivel_actual.exp_necesaria * 1.5)
	var nuevos_beneficios = {
		"vida": nivel_actual.beneficios["vida"] + 2,
		"daño": nivel_actual.beneficios["daño"] + 1
	}
	
	var nuevo_nivel = NodoNivel.new(nuevo_exp, nuevos_beneficios)
	
	# Insertar después del último nivel actual
	var ultimo = cabeza
	while ultimo.siguiente != cabeza:
		ultimo = ultimo.siguiente
	
	ultimo.siguiente = nuevo_nivel
	nuevo_nivel.siguiente = cabeza  # Mantener circularidad

func aplicar_mejoras(jugador: Node):
	for beneficio in nivel_actual.beneficios:
		if beneficio == "vida":
			jugador.vida_maxima += nivel_actual.beneficios[beneficio]
			jugador.vida_actual = jugador.vida_maxima
		elif beneficio == "daño":
			jugador.daño_base += nivel_actual.beneficios[beneficio]

func _imprimir_estructura():
	print("\n=== ESTRUCTURA CIRCULAR ===")
	print("Niveles existentes: ", contador_niveles)
	
	var nodo = cabeza
	var i = 1
	var visitados = {}
	
	while true:
		if visitados.has(nodo):
			break
		
		visitados[nodo] = true
		var marca = " ← ACTUAL" if nodo == nivel_actual else ""
		print("Nivel %d: %d EXP %s %s" % [
			i, 
			nodo.exp_necesaria, 
			nodo.beneficios,
			marca
		])
		
		nodo = nodo.siguiente
		i += 1
	
	print("=== FIN DE ESTRUCTURA ===\n")
