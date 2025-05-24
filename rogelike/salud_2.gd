extends Node
class_name Salud

@export var salud_actual := 100.0
@export var salud_maxima := 100.0
@export var experiencia_otorgada := 25  # EXP que dará al morir

func recibir_daño(cantidad: float):
	salud_actual -= cantidad
	if salud_actual <= 0:
		otorgar_experiencia()
		$"..".queue_free()

func otorgar_experiencia():
	# Busca al jugador en la escena y le da EXP directamente
	var jugadores = get_tree().get_nodes_in_group("jugador")
	if jugadores.size() > 0 and jugadores[0].has_method("ganar_experiencia"):
		jugadores[0].ganar_experiencia(experiencia_otorgada)
