extends Node

@export var melodie_scene: PackedScene
var score

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
	var melodie = melodie_scene.instantiate()
	
	var note_spawn_location = get_node("NotePath/NoteSpawnLocation")
	note_spawn_location.progress_ratio = randf()
	
	var direction = note_spawn_location.rotation + PI / 2
	
	melodie.position = note_spawn_location.position
	
	var velocity = Vector2(200.0, 0.0)
	melodie.linear_velocity = velocity.rotated(direction)
	
	add_child(melodie)
