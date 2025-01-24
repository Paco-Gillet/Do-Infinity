extends Area2D
signal hit

func _on_body_entered(_body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

@export var positions_y := [425 - 50, 525 - 50, 625 - 50, 725 - 50] # Les positions entre les barres noires
var current_index := 1  # Position initiale
var target_y := 0  # Cible verticale
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	target_y = positions_y[current_index]  # Position initiale
	position.y = target_y

func _process(delta):
	if Input.is_action_just_pressed("move_up") and current_index > 0:
		current_index -= 1
		target_y = positions_y[current_index]
	elif Input.is_action_just_pressed("move_down") and current_index < positions_y.size() - 1:
		current_index += 1
		target_y = positions_y[current_index]

	position.y = lerp(position.y, float(target_y), 20 * delta)
