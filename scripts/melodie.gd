extends RigidBody2D

@onready var melodie: AnimatedSprite2D = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	melodie.play("melodie")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() 
