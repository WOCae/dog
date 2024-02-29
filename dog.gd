extends Area2D

const SPEED := 15.0

func _ready() -> void:
	position = Vector2(400,500)	
	scale =  Vector2(2,2)	

func _process(delta: float) -> void:	
	#$AnimatedSprite2D.animation = &"walk"
	#$AnimatedSprite2D.play()
	var velocity = Vector2.ZERO	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1*delta
		$AnimatedSprite2D.animation = &"walk"
		$AnimatedSprite2D.flip_h = false	

	position += velocity.normalized() * SPEED
	$AnimatedSprite2D.play()
