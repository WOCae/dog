extends Area2D

const SPEED := 15.0

func _ready() -> void:
	position = Vector2(400,500)	 #初期位置
	scale =  Vector2(2,2)	#サイズ

func _process(delta: float) -> void:	
	#$AnimatedSprite2D.animation = &"walk"
	#$AnimatedSprite2D.play()
	var velocity = Vector2.ZERO	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1*delta
		$AnimatedSprite2D.animation = &"walk"
		$AnimatedSprite2D.flip_h = false	
		diretFlag = 1
		
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1*delta
		$AnimatedSprite2D.animation = &"walk"
		$AnimatedSprite2D.flip_h = true		
		diretFlag = 2
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1*delta
		$AnimatedSprite2D.animation = &"up"
		diretFlag = 3
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1*delta
		$AnimatedSprite2D.animation = &"down"
		diretFlag = 4
		
	position += velocity.normalized() * SPEED
	$AnimatedSprite2D.play()

	#停止しているかを位置で判定
	if posi == position:
		state = eState.STOP
	if posi != position:
		posi = position
		state = eState.RUN

	#残像の呼び出し
	read_ghost()

#残像の設定

var FreqNum:int = 5 #残像の表示頻度 2:多い　10:少ない

#dogの状態
enum eState {
	STOP,
	RUN,
}

var state = eState.STOP
var ghostNum = 0

@onready var ghostDog = $"GhostLayer"
const ghostSecene = preload("res://dog_ghost.tscn")
var diretFlag:int
var posi = Vector2.ZERO	

func read_ghost() -> void:
	if state == eState.STOP:
		ghostNum = 0
		return 

	# 残像の生成
	ghostNum += 1
	if ghostNum % FreqNum == 1:
		# 残像エフェクト生成
		var eft = ghostSecene.instantiate()
		eft.start(position, scale,diretFlag)
		ghostDog.add_child(eft)

