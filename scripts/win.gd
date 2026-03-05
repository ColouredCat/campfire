extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_win_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		visible = true
		print("win")
		get_tree().paused = true
