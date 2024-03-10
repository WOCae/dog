extends Area2D

const SPEED := 1.0


#ボールの出力
@export var speed = 15
@export var Shotcnt = 0.1 #射出間隔
@export var ShotSpeed = 1000 #速度
var cnt = 0
const Ball = preload("res://ball.tscn") #ballシーンのプリロード

var rotation1:float
enum RState {
upleft,
upRight,
downRight,
downleft,
}
var current_RState = RState.upleft

func _ready() -> void:
	position = Vector2(400,500)	 #初期位置
	scale =  Vector2(2,2)	#サイズ

func _process(delta: float) -> void:	
	#$AnimatedSprite2D.animation = &"walk"
	#$AnimatedSprite2D.play()
	var velocity = Vector2.ZERO	
	var flagsum:String
	var flagup:String
	var flagdown:String
	var flagleft:String
	var flagright:String
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1*delta
		$AnimatedSprite2D.animation = &"walk"
		$AnimatedSprite2D.flip_h = false	
		diretFlag = 1
		rotation1 = 270
		flagleft = "1"
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1*delta
		$AnimatedSprite2D.animation = &"walk"
		$AnimatedSprite2D.flip_h = true		
		diretFlag = 2
		rotation1 = 90
		flagright = "2"
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1*delta
		$AnimatedSprite2D.animation = &"up"
		diretFlag = 3
		rotation1 = 0
		flagup = "3"
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1*delta
		$AnimatedSprite2D.animation = &"down"
		diretFlag = 4
		rotation1 = 180
		flagdown = "4"
		
	position += velocity.normalized() * SPEED
	$AnimatedSprite2D.play()

	#停止しているかを位置で判定
	if posi == position:
		state = eState.STOP
	if posi != position:
		posi = position
		state = eState.RUN

	#斜め判定
	flagsum = flagleft + flagright + flagup + flagdown
	print(flagsum)

	if "1" in flagsum && "3" in flagsum  :
		current_RState = RState.upleft
		rotation1 = 315

	if "2" in flagsum && "3" in flagsum  :
		current_RState = RState.upRight
		rotation1 = 45

	if "2" in flagsum && "4" in flagsum  :
		current_RState = RState.downRight
		rotation1 = 135

	if "1" in flagsum && "4" in flagsum  :
		current_RState = RState.downleft
		rotation1 = 225	

		
	#弾の発射
	if Input.is_action_pressed(("ui_select")):
		
	#ballを作成する　スペースを押すとボールが作成されます。		
		cnt += delta
		if cnt > Shotcnt:
			cnt -= Shotcnt
		
			# ball 
			var Ball = Ball.instantiate()
			Ball.position = position
			
			# ballの位置と速度,角度
			Ball.start(position.x, position.y, ShotSpeed,rotation1)
			
			#ルートにインスタンスを追加
			var mainNode = get_owner()
			mainNode.add_child(Ball)
			#add_child(Ball)

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

