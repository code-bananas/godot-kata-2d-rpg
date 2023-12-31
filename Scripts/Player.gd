extends CharacterBody2D

@onready var animation_tree:AnimationTree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

enum player_states {MOVE, SWORD, JUMP, DEAD}
var current_state:player_states = player_states.MOVE

var input_movement:Vector2 = Vector2.ZERO
var speed:int = 70

func _ready():
	$Sword/CollisionShape2D.disabled = true

func _physics_process(delta):
	match current_state:
		player_states.MOVE:
			_move()
		player_states.SWORD:
			sword()
		player_states.JUMP:
			jump()
		player_states.DEAD:
			dead()
			
func _move():
	input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_movement != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_movement)
		animation_tree.set("parameters/Walk/blend_position", input_movement)
		animation_tree.set("parameters/Sword/blend_position", input_movement)
		animation_tree.set("parameters/Jump/blend_position", input_movement)
		animation_state.travel("Walk")
		velocity = input_movement * speed

	if input_movement == Vector2.ZERO:
		animation_state.travel("Idle")
		velocity = Vector2.ZERO
		
	if Input.is_action_just_pressed("Sword"):
		current_state = player_states.SWORD
		
	if Input.is_action_just_pressed("Jump"):
		current_state = player_states.JUMP
	
	if PlayerData.health <= 0:
		current_state = player_states.DEAD
		
	move_and_slide()

func sword():
	animation_state.travel("Sword")

func jump():
	animation_state.travel("Jump")
	velocity = input_movement * speed
	move_and_slide()

func dead():
	animation_state.travel("dead")
	await get_tree().create_timer(1).timeout
	PlayerData.health = 4
	get_tree().reload_current_scene()
	
func flash():
	$Sprite2D.material.set_shader_parameter("flash_modifier", 1)
	await get_tree().create_timer(0.3).timeout
	$Sprite2D.material.set_shader_parameter("flash_modifier", 0)
	
func on_states_reset():
	current_state = player_states.MOVE

func clear_collision():
	$CollisionShape2D.disabled = true
	
func create_collision():
	$CollisionShape2D.disabled = false

func _on_hitbox_area_entered(area):
	flash()
