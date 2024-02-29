extends AnimatedSprite2D

var delTime:float

#残像開始
func start(DogPos:Vector2, DogScale:Vector2,diretFlag:int):
	position = DogPos
	scale = DogScale
	delTime = 1.0
	
	if diretFlag == 1:
		animation = &"walk"
		flip_h = false		
	elif diretFlag == 2:
		animation = &"walk"
		flip_h = true		
	elif diretFlag == 3:
		animation = &"up"
	elif diretFlag == 4:
		animation = &"down"
	
	play()
	
func _process(delta: float) -> void:
	delTime -= delta
	if delTime <= 0:
		queue_free()
		pass
	var alpha = delTime * 0.5
	modulate.a = alpha
