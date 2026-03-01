extends CharacterBody2D


var SPEED = 300.0
var JUMP_VELOCITY = -400.0
var GRAVITY = 1
var IS_WET = false

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	$AnimatedSprite2D.flip_h = false
	
func animate():
	if velocity.x > 0:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = false
		if velocity.y != 0:
			$AnimatedSprite2D.play("jump")
	elif velocity.x < 0:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = true
		if velocity.y != 0:
			$AnimatedSprite2D.play("jump")
	elif velocity.x == 0:
		$AnimatedSprite2D.play("idle")
		$AnimatedSprite2D.flip_h = false
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY

	# Handle jump.
	if Input.is_action_just_pressed("up") and not IS_WET and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("up") and IS_WET:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("right", "left")
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	animate()
	move_and_slide()


func _on_water_body_entered(body: Node2D) -> void:
	print("in")
	if body.is_in_group("player"):
		GRAVITY = 0.1
		IS_WET = true


func _on_water_body_exited(body: Node2D) -> void:
	print("out")
	if body.is_in_group("player"):
		GRAVITY = 1
		IS_WET = false
