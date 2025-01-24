extends Node

@export var melodie_scene: PackedScene
var score
var lastTimeToSpawn = 0

func _ready():
	new_game()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	

func game_over() -> void:
	$ScoreTimer.stop()
	$NoteTimer.stop()


func _on_start_timer_timeout() -> void:
	$NoteTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout() -> void:
	score += 1


func _on_note_timer_timeout() -> void:
	
	lastTimeToSpawn += get_process_delta_time()
	

	if(lastTimeToSpawn >=0.05): 
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
