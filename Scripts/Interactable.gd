extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hit_box_area_entered(area):
	if area.name == "Sword":
		$AnimationPlayer.play("Destroyed")
		await $AnimationPlayer.animation_finished
		queue_free()
