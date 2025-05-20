# base_item.gd
extends Node2D
class_name BaseItem
var is_item = true
@export var item_id: int = 1
@export var item_name: String = "pistola"
@export var texture = "res://Personajes/Imagen1.png"
@export var max_stack: int = 1
@export var current_amount: int = 1

func use(player):
	pass  # Sobreescribir en items específicos
