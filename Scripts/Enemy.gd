extends EnemyMovement

func _ready():
	random_generation()

func _on_timer_timeout():
	random_generation()

func _on_hit_box_area_entered(area):
	if area.is_in_group("Sword"):
		flash()
		health -= 1

func flash():
	$Sprite2D.material.set_shader_parameter("flash_modifier", 1)
	await get_tree().create_timer(0.3).timeout
	$Sprite2D.material.set_shader_parameter("flash_modifier", 0)
