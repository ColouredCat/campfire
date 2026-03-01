extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	var rand = rng.randi_range(0, 2)
	if rand == 1:
		play("grassA")
	elif rand == 0:
		play("grassB")
	elif rand == 2:
		play("grassC")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
