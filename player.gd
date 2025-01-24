extends CollisionShape2D

signal hit

func _on_body_entered(_body):
	hide()
	hit.emit()
	#desactive la hitbox du player
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
