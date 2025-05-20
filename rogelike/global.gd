extends Node

var personaje_seleccionado: String = "personaje"  # valor por defecto
var personajes_disponibles = {
	"personaje": {
		"ruta": "res://personaje.tscn",
		"nombre": "Héroe",
		"tipo": "masculino"
	},
	"femina": {
		"ruta": "res://Personajes/femina.tscn",
		"nombre": "Heroína",
		"tipo": "femenino"
	}
}
var inventory:Array[int] = []
const Max = 4
