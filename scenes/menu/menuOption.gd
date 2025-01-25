extends Control

@export var volume_scroll_bar : HScrollBar

var volume

func _ready():
	var fullscreen = DisplayServer.window_get_mode() == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN
	$TabContainer/Video/MarginContainer2/ScrollContainer/VBoxContainer/HBoxContainer/FullScreenCheckButton.button_pressed = fullscreen
	$TabContainer/Video/MarginContainer2/ScrollContainer/VBoxContainer/HBoxContainer/FullScreenCheckButton.connect(
		"toggled", 
		Callable(self, "_on_full_screen_check_button_toggled")
	)
	load_volume()

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/menuDebut.tscn")

func _on_full_screen_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)


func _on_h_scroll_bar_value_changed(value: float) -> void:
	volume = value
	if volume == -40:
		volume = -1000
	AudioServer.set_bus_volume_db(0, volume)
	save_volume()
	
func save_volume():
	var save_file = ConfigFile.new()
	save_file.set_value("options", "volume", volume)
	var error = save_file.save("user://options.save")
	if error != OK:
		print("Erreur lors de la sauvegarde du fichier : ", error)

func load_volume():
	var save_file = ConfigFile.new()
	var error = save_file.load("user://options.save")

	if error != OK:
		print("Aucun fichier de sauvegarde trouvé, initialisation du meilleur score.")
		volume = 0
	else:
		volume = save_file.get_value("options", "volume", volume)
		volume_scroll_bar.set_value(volume)
