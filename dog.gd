extends Area2D

func _ready() -> void:
	position = Vector2(400,500)	
	scale =  Vector2(2,2)	

func _process(delta: float) -> void:	
	$AnimatedSprite2D.animation = &"walk"
	$AnimatedSprite2D.play()
