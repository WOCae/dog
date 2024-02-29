extends AnimatedSprite2D

var _timer:float

# ゴーストエフェクト開始
func start(_position:Vector2, _scale:Vector2,diretFlag:int):
	position = _position
	#position.x = _position.x-10
	#position.y = _position.y-10
	#print(_position)
	scale = _scale
	#frame = _frame
	#flip_h = _flip_h
	_timer = 1.0
	
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
	#if position == _position:
		#queue_free()
		
func _process(delta: float) -> void:
	_timer -= delta
	if _timer <= 0:
		# タイマー終了で消える
		
	#await get_tree().create_timer(0.5).timeout
		queue_free()
		pass
	var alpha = _timer * 0.5
	modulate.a = alpha
