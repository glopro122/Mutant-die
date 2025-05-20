extends Control
var username
var password
var data = "res://data/data.csv"
var file = FileAccess
var i = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_salir_pressed() -> void:
	get_tree().quit()

func _on_jugar_pressed() -> void:
	# Leer contenido existente (igual que antes)
	var no = file.open(data, FileAccess.READ)
	var contenido = no.get_as_text()
	contenido = contenido.split("\n")
	contenido = Array(contenido)
	contenido.erase("")
	no.close()  # Cerrar archivo de lectura
	
	# Obtener nuevos datos (igual que antes)
	username = $ColorRect/VBoxContainer/HBoxContainer2/username.text
	password = $ColorRect/VBoxContainer/HBoxContainer3/password.text
	var datos = [username, password]
	
	# Escribir todo de nuevo (modificado)
	var si = file.open(data, FileAccess.WRITE)  # WRITE borra el contenido, pero nosotros ya guardamos lo anterior en 'contenido'
	
	# Escribir líneas existentes (CORRECCIÓN: usamos 'linea' en lugar de 'contenido[i]')
	for linea in contenido:
		if linea != "":  # Asegurar que no escribimos líneas vacías
			si.store_csv_line(linea.split(";"), ";")  # Dividir y volver a unir para formato consistente
	
	# Escribir nuevo dato (igual que antes)
	si.store_csv_line(datos, ";")
	si.close()
	
	get_tree().change_scene_to_file("res://menu.tscn")
