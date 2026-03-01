extends Area2D
var left = false

var speed = 300
@export var timeout = 3.5
var rng = RandomNumberGenerator.new()
var dead = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("flicker")
	$MoveTimer.start(timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if dead:
		return
	
	if not left:
		position.x += speed * delta
	else:
		position.x -= speed * delta

func _on_move_timer_timeout() -> void:
	left = !left

func _on_timer_timeout() -> void:
	position.y += rng.randf_range(20, -20)


func _on_player_scr() -> void:
	dead = true
	visible = false
