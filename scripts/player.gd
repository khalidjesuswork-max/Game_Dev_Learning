extends CharacterBody2D

@onready var hit_test: Area2D = $"../Hit_Test"

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var applied_y = 0;
var hit_dir : int = 1;
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

		# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	#Flip Based on direction
	if direction > 0: animated_sprite.flip_h = false
	else: if direction < 0: animated_sprite.flip_h = true
	
	#Animate move/idle/jump
	if animated_sprite.animation != "hit":
		if is_on_floor():
			if direction: animated_sprite.play("run");
			else: animated_sprite.play("idle");
		else: animated_sprite.play("jump");
	else: if animated_sprite.frame == 10: animated_sprite.play("idle")
		
	if direction:
		if not hit_test.Hitted: velocity.x = direction * SPEED
	else:
		if not hit_test.Hitted: velocity.x = move_toward(velocity.x, 0, SPEED)

# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		if not hit_test.Hitted: velocity.y = JUMP_VELOCITY
		print(direction)
	
	if hit_test.Hitted: 
		if not applied_y:
			animated_sprite.play("hit"); animated_sprite.frame = 0;
			if velocity.y > 0: velocity.y = hit_test.Hit_Y
			else: velocity.y = -sqrt(velocity.y**2 + hit_test.Hit_Y**2)
			applied_y = 1;
			hit_dir = -sign(velocity.x)
		velocity.x = hit_dir*hit_test.Hitted * SPEED * 0.2
	else: applied_y = 0;

	move_and_slide()
