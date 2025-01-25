extends AudioStreamPlayer

@export var speedcore : AudioStream

func _ready():
	connect("finished", Callable(self, "_on_finished")) 

func _on_finished():
	# Vérifie si c'est la dernière piste de la playlist
	if stream is AudioStreamPlaylist:
		stream = speedcore
		play()
