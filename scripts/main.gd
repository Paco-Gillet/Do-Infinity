extends Area2D

@export var speed = 1000
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2.ZERO
	#setup les input dans projet > parametre projet > controle
	if Input.is_action_pressed("haut"):
		velocity.y -= 1
	if Input.is_action_pressed("bas"):
		velocity.y +=1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed; #setup la base speed du mouvement
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta #gère la position
	position = position.clamp(Vector2.ZERO, screen_size)
