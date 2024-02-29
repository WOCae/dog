extends Area2D

const SPEED := 15.0

# 状態
enum eState {
	IDLE,
	RUN,
}

var state = eState.IDLE
var ghost_cnt = 0

@onready var _ghost_effects = $"GhostEffectLayer"
const GHOST_EFFECT = preload("res://dog_ghost.tscn")
var diretFlag:int
var posi = Vector2.ZERO	

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

	if posi == position:
		state = eState.IDLE
	if posi != position:
		posi = position
		state = eState.RUN


	# 残像エフェクトの処理
	_proc_ghost_effect()
	
func _proc_ghost_effect() -> void:
	if state == eState.IDLE:
		ghost_cnt = 0
		return # 停止中は何もしない

	# 残像エフェクトを生成判定
	ghost_cnt += 1
	if ghost_cnt%5== 1:
		#_ghost_effects.show()
		# 残像エフェクト生成
		var eft = GHOST_EFFECT.instantiate()
		eft.start(position, scale,diretFlag)
		_ghost_effects.add_child(eft)
		#ghost_cnt = 0
