extends KinematicBody2D

export var MAX_SPEED: float = 100.0
export var MAX_ROTATION_SPEED: float = 1.6

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _physics_process(delta):
    var angle = self.rotation
    var speed = Vector2(cos(angle), sin(angle))
    print(speed)
    
    if Input.is_action_pressed("player1_forward"):
        self.move_and_collide( speed * MAX_SPEED * delta)
    if Input.is_action_pressed("player1_backward"):
        self.move_and_collide(-speed * MAX_SPEED * delta)
    if Input.is_action_pressed("player1_left"):
        self.rotate(-MAX_ROTATION_SPEED*delta)
    if Input.is_action_pressed("player1_right"):
        self.rotate( MAX_ROTATION_SPEED*delta)
