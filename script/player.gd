extends CharacterBody2D

@onready var animation_sprite = $AnimatedSprite2D
@export var speed= 50
var new_direction = Vector2(0,1) #only move one spaces
var animation
func _physics_process(delta):
		# Get player input (left, right, up/down)
		var direction: Vector2
		direction.x = Input.get_action_strength("right") -Input.get_action_strength("left")

		direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")

		# If input is digital, normalize it for diagonal movement
		if abs(direction.x) == 1 and abs(direction.y) == 1:
			direction = direction.normalized()

		# Apply movement
		var movement = speed * direction * delta
		# Moves our player around, whilst enforcing collisions so that they come to a stop when colliding with another object.
		move_and_collide(movement)
		player_animations(direction)
		
func player_animations(direction : Vector2):
	#Vector2.ZERO is the shorthand for writing Vector2(0, 0).
		if direction != Vector2.ZERO:
			#update our direction with the new_direction
			new_direction = direction
			#play walk animation because we are moving
			animation = "walk_"+ returned_direction(new_direction)
			animation_sprite.play(animation)
		else:
			#play idle animation because we are still
			animation  = "idle_"+ returned_direction(new_direction)
			animation_sprite.play(animation)
			
func returned_direction(direction : Vector2):
		#it normalizes the direction vector 
		var normalized_direction  = direction.normalized()
		var default_return = "side"

		if normalized_direction.y > 0:
			return "down"	
		elif normalized_direction.y < 0:
			return "up"
		elif normalized_direction.x > 0:
			#(right)
			$AnimatedSprite2D.flip_h = false
			return "side"
		elif normalized_direction.x < 0:
			#flip the animation for reusability (left)
			$AnimatedSprite2D.flip_h = true
			return "side"

		#default value is empty
			return default_return
