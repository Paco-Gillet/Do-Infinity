extends AudioStreamPlayer

var was_stopped = false

func _ready():
	if not playing and not was_stopped:
		play()
