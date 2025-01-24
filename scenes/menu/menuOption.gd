extends Control

func _ready():
	var fullscreen = DisplayServer.window_get_mode() == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN
	$TabContainer/Video/MarginContainer2/ScrollContainer/VBoxContainer/HBoxContainer/FullScreenCheckButton.button_pressed = fullscreen
	$TabContainer/Video/MarginContainer2/ScrollContainer/VBoxContainer/HBoxContainer/FullScreenCheckButton.connect(
		"toggled", 
		Callable(self, "_on_full_screen_check_button_toggled")
	)

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/menuDebut.tscn")

func _on_full_screen_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
