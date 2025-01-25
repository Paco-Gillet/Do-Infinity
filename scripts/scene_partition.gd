extends Node

@export var note_scene: PackedScene
var score

func _ready():
	new_game()

func game_over():
	$ScoreTimer.stop()
	$NoteTimer.stop()
	
func new_game():
	score = 0
	MenuMusicPlayer.was_stopped = true
	MenuMusicPlayer.stop()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
func _on_start_timer_timeout():
	$NoteTimer.start()
	$ScoreTimer.start()
	
func _on_score_timer_timeout():
	score += 1
	
func _on_note_timer_timeout():
	var note = note_scene.instantiate()
	
	var note_spawn_location = get_node("NotePath/NoteSpawnLocation")
	note_spawn_location.progress_ratio = randf()
	
	var direction = note_spawn_location.rotation
	
	note.position = note_spawn_location.position
	
	var velocity = Vector2(200.0, 0.0)
	note.linear_velocity = velocity.rotated(direction)
		
	add_child(note)
