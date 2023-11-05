extends CharacterBody2D
class_name EnemyMovement

var current_state: enemy_state = enemy_state.MOVEDOWN
enum enemy_state {MOVERIGHT, MOVELEFT, MOVEUP, MOVEDOWN, DEAD}

@onready var dead_anim = preload("res://Scenes/Effects/Dead_FX.tscn")
@onready var coin_loot = preload("res://Scenes/Interactables/Coin.tscn")
@export var speed: int = 10
@export var health: int = 3
var dir

func _physics_process(delta):
	if health <= 0:
		current_state = enemy_state.DEAD
	
	match current_state:
		enemy_state.MOVERIGHT:
			move_right()
		enemy_state.MOVELEFT:
			move_left()
		enemy_state.MOVEUP:
			move_down()
		enemy_state.MOVEDOWN:
			move_up()
		enemy_state.DEAD:
			dead()
			
	move_and_slide()

func random_direction():
	match dir:
		0:
			current_state = enemy_state.MOVERIGHT
		1:
			current_state = enemy_state.MOVELEFT
		2:
			current_state = enemy_state.MOVEUP
		3:
			current_state = enemy_state.MOVEDOWN

func random_generation():
	dir = randi() % 4
	random_direction()
	

func move_right():
	velocity = Vector2.RIGHT * speed
	$AnimationPlayer.play("move_right")
	
func move_left():
	velocity = Vector2.LEFT * speed
	$AnimationPlayer.play("move_left")
	
func move_down():
	velocity = Vector2.DOWN * speed
	$AnimationPlayer.play("move_down")
	
func move_up():
	velocity = Vector2.UP * speed
	$AnimationPlayer.play("move_up")
	
func dead():
	dead_animation()
	queue_free()

func dead_animation():
	var dead = dead_anim.instantiate()
	dead.global_position = global_position
	get_tree().get_root().add_child(dead)
	loot_coin()

func loot_coin():
	var coin = coin_loot.instantiate()
	coin.global_position = global_position
	get_tree().get_root().add_child(coin)
	
