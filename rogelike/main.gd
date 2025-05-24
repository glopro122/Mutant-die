extends Node

func _ready():
	var sistema_niveles = preload("res://Niveles.tscn").new()
	add_child(sistema_niveles)
	toggle_fullscreen()
	var jugador = $Player
	
	# Conectar señal para actualizar UI (ejemplo)
	sistema_niveles.connect("nivel_subido", self, "_on_nivel_subido")

func _on_nivel_subido(nivel_actual):
	print("¡Nivel subido a: ", nivel_actual, "!")
	# Aquí puedes actualizar la UI, reproducir sonidos, etc.

func toggle_fullscreen():
	var current_mode = DisplayServer.window_get_mode()
	var new_mode = DisplayServer.WINDOW_MODE_WINDOWED if current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN else DisplayServer.WINDOW_MODE_FULLSCREEN
	DisplayServer.window_set_mode(new_mode)

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		toggle_fullscreen()
