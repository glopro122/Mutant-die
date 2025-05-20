extends Control

# Asigna estos en el inspector arrastrando los nodos
@export var boton_personaje_1: Button
@export var boton_personaje_2: Button
@export var anim_player: AnimationPlayer

func _ready():
	pass

func _on_personaje_1_selected():
	Global.personaje_seleccionado = "personaje"
	_cambiar_a_escena_principal()

func _on_personaje_2_selected():
	Global.personaje_seleccionado = "femina"
	_cambiar_a_escena_principal()

func _cambiar_a_escena_principal():
	if anim_player:
		anim_player.play("transicion")
		await anim_player.animation_finished
	get_tree().change_scene_to_file("res://main.tscn")

func _on_mago_pressed() -> void:
	_on_personaje_1_selected()

func _on_mujer_pressed() -> void:
	_on_personaje_2_selected()
