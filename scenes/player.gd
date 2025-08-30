extends CharacterBody2D

@export var speed: int = 500
var rot_speed = 35

var offset = 50

var cooldown: bool = false

signal laser(pos)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(get_viewport().get_visible_rect().size[0] * 0.5, get_viewport().get_visible_rect().size[1] * 0.5)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	#print(direction)
	velocity = direction * speed
	move_and_slide()
	# $Sprite2D.rotation += rot_speed * delta * (max(abs(direction.x),abs(direction.y))) / (max(direction.x,direction.y))
	
	if Input.is_action_just_pressed("Shoot") and cooldown == false:
		#print(position)
		laser.emit($LaserStartPosition.position + position)
		cooldown = true
		$Cooldown.start(0.5)
		

func _on_cooldown_timeout() -> void:
	cooldown = false
	
