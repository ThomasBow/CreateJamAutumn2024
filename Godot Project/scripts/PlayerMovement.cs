using Godot;

public partial class PlayerMovement : CharacterBody2D
{
	[Export]
	public int speed = 300;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}
	
	public void CalculateMovement() {
		// Get direction
		Vector2 directionVector += Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");
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
