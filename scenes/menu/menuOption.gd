extends Control

func _ready():
	$TabContainer/Video/MarginContainer2/ScrollContainer/VBoxContainer/HBoxContainer/FullScreenCheckButton.connect("toggled", Callable(self, "_on_fullscreen_toggled"))

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/menuDebut.tscn")

func _on_full_screen_check_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
