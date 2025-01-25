extends Node

@export var melodie_scene: PackedScene
var score
var high_score
var lastTimeToSpawn = 0

func _ready():
	load_high_score()
	new_game()

func new_game():
	score = 0
	$Score.text = "Score: " + str(score/10)
	$Score.show()
	$Player.start($StartPosition.position)
	$StartTimer.start()

func game_over() -> void:
	$ScoreTimer.stop()
	$NoteTimer.stop()
	if score > high_score:
		high_score = score
		print("Nouveau meilleur score : " + str(high_score / 10))
		save_high_score()
	get_tree().change_scene_to_file("res://scenes/menu/menuDebut.tscn")


func _on_start_timer_timeout() -> void:
	$NoteTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout() -> void:
	score += 1
	$Score.text = "Score: " + str(score/10)
	$Score.show()


func _on_note_timer_timeout() -> void:
	
	lastTimeToSpawn += get_process_delta_time()
	

	if(lastTimeToSpawn >=0.01): 
		lastTimeToSpawn = 0
		var melodie = melodie_scene.instantiate()
		var nbPointSpawn: int = randi_range(1,4) 
		
		var pathPointSpawn : String =  str("NotePath/PointSpawnLocation",nbPointSpawn)
		var note_spawn_location = get_node(pathPointSpawn)

		var direction = note_spawn_location.rotation + PI / 2
		var velocity = Vector2(200.0, 0.0).rotated(direction)
	
		melodie.position = note_spawn_location.position

		melodie.set_velocity(velocity)
	
		add_child(melodie)

# Sauvegarder le meilleur score dans un fichier
func save_high_score():
	var save_file = ConfigFile.new()
	save_file.set_value("scores", "high_score", high_score)
	var error = save_file.save("user://high_score.save")
	if error != OK:
		print("Erreur lors de la sauvegarde du fichier : ", error)

func load_high_score():
	var save_file = ConfigFile.new()
	var error = save_file.load("user://high_score.save")

	if error != OK:
		print("Aucun fichier de sauvegarde trouvé, initialisation du meilleur score.")
		high_score = 0
	else:
		high_score = save_file.get_value("scores", "high_score", 0)

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		game_over()
