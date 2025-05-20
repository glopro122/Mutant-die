extends Node
@export var salud_actual := 100.0
@export var salud_maxima := 100.0
@export var barra_salud : BarraSalud
func recibir_daño (cantidad: float):
	salud_actual -= cantidad
	actualizar_salud()
	if salud_actual <= 0:
		print("EL PERSONAJE NO TIENE SALUD")
		get_tree().change_scene_to_file("res://menu.tscn")
		
func actualizar_salud():
	if BarraSalud:
		$"../Vida".actualizar_barra(salud_maxima,salud_actual)
