extends RigidBody2D

@export var SPEED = 0.6
var wet = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D.flip_h = true


# Called every frame. 'delta' is the elapsed time since the prtreevious frame.
func _physics_process(delta: float) -> void:
	if not wet:
		apply_central_force(Vector2(0, 15000))
	
	var frog = get_tree().get_nodes_in_group("player")[0].position
	
	var movement = (position - frog) 
	
	if movement.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
	apply_central_force(-(movement * SPEED))


func _on_water_body_exited(body: Node2D) -> void:
	wet = false


func _on_water_body_entered(body: Node2D) -> void:
	wet = true
