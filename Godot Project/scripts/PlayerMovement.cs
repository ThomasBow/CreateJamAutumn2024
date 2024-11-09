using Godot;

public partial class PlayerMovement : CharacterBody2D
{
	[Export]
	public int speed = 300;
	
	private AnimatedSprite2D _animatedSprite2D;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		_animatedSprite2D = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
	}
	
	public void CalculateMovement() {
		// Get direction
		Vector2 directionVector = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");
		
		//Flips the fucking sprite
		if (directionVector.X < 0) {
			_animatedSprite2D.Scale = new Vector2(1, 1);
		}
		else if (directionVector.X > 0) {
			_animatedSprite2D.Scale = new Vector2(-1, 1);
		}
		/*if (directionVector == Vector2.Right && this.Transform.Scale.X == 1) {
			this.Transform = this.Transform.ScaledLocal(new Vector2(-1,1));
		}
		else if (directionVector == Vector2.Left && this.Transform.Scale.X == -1) {
			this.Transform = this.Transform.ScaledLocal(new Vector2(-1,1));
		}*/
		
		
		// Calculate movement vector
		Velocity = directionVector * speed;
	}
	
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(double delta)
	{
		CalculateMovement();//This function uses delta itself
		MoveAndSlide();
	}
}
