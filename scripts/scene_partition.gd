extends Node

@export var melodie_scene: PackedScene
@export var note_scene : PackedScene

var score
var high_score
var lastLineSpawn = 0
var repComp = 0
var isMelodie = true


func _ready():
	load_high_score()
	$HighScore.text = "High score: " + str(high_score)
	$HighScore.show()
	new_game()

func new_game():
	score = 0
	MenuMusicPlayer.was_stopped = true
	MenuMusicPlayer.stop()
	$Score.text = "Score: " + str(score)
	$Score.show()
	$Player.start($StartPosition.position)
	$StartTimer.start()

func game_over() -> void:
	$ScoreTimer.stop()
	$SpawnTimer.stop()
	if score > high_score:
		high_score = score
		print("Nouveau meilleur score : " + str(high_score))
		save_high_score()
	save_last_score()
	get_tree().change_scene_to_file("res://scenes/menu/menuDebut.tscn")


func _on_start_timer_timeout() -> void:
	$SpawnTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout() -> void:
	score += 1
	$Score.text = "Score: " + str(score)
	$Score.show()


func _on_spawn_timer_timeout() -> void:
	if !isMelodie:
		var note = note_scene.instantiate()

		var nbPointSpawn: int = randi_range(1,4) 
		if(nbPointSpawn == lastLineSpawn && repComp>=2):
			repComp += 1
		else :
			if(repComp==3):
				while (nbPointSpawn == lastLineSpawn ):
					nbPointSpawn = randi_range(1,4) 
				repComp = 0

		var pathPointSpawn : String =  str("NotePath/PointSpawnLocation",nbPointSpawn)
		var spawn_location = get_node(pathPointSpawn)
		var direction = spawn_location.rotation + PI / 2
		var velocity = lerp(Vector2(300.0, 0.0).rotated(direction),Vector2(3000.0, 0.0).rotated(direction),0.2)
		
		note.position =  spawn_location.position
		note.set_velocity(velocity)
		add_child(note)
		isMelodie=true
	else :
		var melodie = melodie_scene.instantiate()
	
		var nbPointSpawn: int = randi_range(1,4) 
		if(nbPointSpawn == lastLineSpawn && repComp>=2):
			repComp += 1
		else :
			if(repComp==3):
				while (nbPointSpawn == lastLineSpawn ):
					nbPointSpawn = randi_range(1,4) 
				repComp = 0

		var pathPointSpawn : String =  str("NotePath/PointSpawnLocation",nbPointSpawn)
		var spawn_location = get_node(pathPointSpawn)
		
		var direction = spawn_location.rotation + PI / 2
		var velocity = lerp(Vector2(300.0, 0.0).rotated(direction),Vector2(3000.0, 0.0).rotated(direction),0.2)
		
			
		melodie.position = spawn_location.position
		melodie.set_velocity(velocity)
		add_child(melodie)
		isMelodie=false
	if $SpawnTimer.wait_time > 0.1:
		$SpawnTimer.wait_time = lerp(0.5,0.1,0.8)
	
func save_high_score():
	var save_file = ConfigFile.new()
	save_file.set_value("scores", "high_score", high_score)
	var error = save_file.save("user://high_score.save")
	if error != OK:
		print("Erreur lors de la sauvegarde du fichier : ", error)

func save_last_score():
	var save_file = ConfigFile.new()
	save_file.set_value("scores", "last_score", score)
	var error = save_file.save("user://last_score.save")
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
