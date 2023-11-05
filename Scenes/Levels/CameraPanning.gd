extends Camera2D

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = player.position
	
	var x = floor(position.x / 320) * 320
	var y = floor(position.y / 180) * 180
	
	position = Vector2(x,y)
	
	#var tween := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(self, "position", Vector2(x,y), 0.14)
