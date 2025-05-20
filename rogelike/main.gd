extends Node

func _ready():
	toggle_fullscreen()

func toggle_fullscreen():
	var current_mode = DisplayServer.window_get_mode()
	var new_mode = DisplayServer.WINDOW_MODE_WINDOWED if current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN else DisplayServer.WINDOW_MODE_FULLSCREEN
	DisplayServer.window_set_mode(new_mode)

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		toggle_fullscreen()
