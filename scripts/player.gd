extends CharacterBody2D
signal dead
signal scr

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -500.0
@export var WATER_FACTOR = 3
var GRAVITY = 1
var IS_WET = false
var lives = 3
var hit = false
var score = 0

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
		
		
func collisions():
	for i in get_slide_collision_count():
		if get_slide_collision(i).get_collider().is_in_group("enemy"):
			print("bite")
			hit = true
			lives -= 1
			get_tree().get_nodes_in_group("lives")[0].play(str(lives))
			$HitTimer.start()
			return

func _physics_process(delta: float) -> void:
	if lives == 0:
		emit_signal("dead")
		return
	
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
	if not hit:
		collisions()

func _on_water_body_entered(body: Node2D) -> void:
	print("in")
	if body.is_in_group("player"):
		GRAVITY = WATER_FACTOR
		IS_WET = true


func _on_water_body_exited(body: Node2D) -> void:
	print("out")
	if body.is_in_group("player"):
		GRAVITY = 1
		IS_WET = false


func _on_hit_timer_timeout() -> void:
	hit = false
	$AnimatedSprite2D.visible = true

func _on_flash_timer_timeout() -> void:
	if hit:
		$AnimatedSprite2D.visible = !$AnimatedSprite2D.visible


func _on_firefly_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("collide")
		score += 1
