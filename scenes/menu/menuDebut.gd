extends Control

func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://scenes/Scene_partition.tscn")


func _on_button_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/menuOption.tscn")


func _on_button_quit_pressed():
	get_tree().quit()
