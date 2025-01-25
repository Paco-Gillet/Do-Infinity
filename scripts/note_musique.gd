extends RigidBody2D

@onready var melodie: AnimatedSprite2D = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	melodie.play("melodie")
	
func set_velocity(new_velocity: Vector2) -> void:
	velocity = new_velocity
	linear_velocity = velocity
	
func _physics_process(delta: float) -> void:
	# Verrouille la vitesse à celle définie initialement
	linear_velocity = velocity



func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
