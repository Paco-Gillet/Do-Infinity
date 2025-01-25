extends Control

var high_score
var last_score

func _ready():
    if MenuMusicPlayer.was_stopped:
		MenuMusicPlayer.was_stopped = false
		MenuMusicPlayer.play()
	load_high_score()
	$VBoxText/HighScore.text = "High score: " + str(high_score)
	$VBoxText/HighScore.show()
	load_last_score()
	$VBoxText/Score.text = "Last score: " + str(last_score)
	$VBoxText/Score.show()

func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://scenes/Scene_partition.tscn")


func _on_button_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/menuOption.tscn")


func _on_button_quit_pressed():
	get_tree().quit()
	
func load_high_score():
	var save_file = ConfigFile.new()
	var error = save_file.load("user://high_score.save")

	if error != OK:
		print("Aucun fichier de sauvegarde trouvé, initialisation du meilleur score.")
		high_score = 0
	else:
		high_score = save_file.get_value("scores", "high_score", 0)

func load_last_score():
	var save_file = ConfigFile.new()
	var error = save_file.load("user://last_score.save")

	if error != OK:
		print("Aucun fichier de sauvegarde trouvé, initialisation du meilleur score.")
		last_score = 0
	else:
		last_score = save_file.get_value("scores", "last_score", 0)
