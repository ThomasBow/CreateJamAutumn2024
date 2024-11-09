using Godot;
using System;

public partial class AiCustomer : Node2D
{
	// define grid properties
	private Vector2 targetPosition;
	private Vector2 currentPosition;
	private const float gridSize = 16f; // grid size now 16x16
	private const float speed = 300f; // speed of an customer

	private bool[,] grid; // initialize this based on your level setup

	public override void _Ready()
	{
		// initialize position to start at the box's location on the grid
		currentPosition = Position / gridSize;
		targetPosition = currentPosition;

		// define your grid, where true = occupied non movable space
		grid = new bool[,] {
			{ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
			{ false, true, true, true, true, true, true, true, true, true, false, true, true, true, true, true, false, },
			{ false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, },
			{ false, true, true, false, false, false, false, true, true, true, false, true, true, true, true, true, false, },
			{ false, true, true, true, true, true, false, true, true, true, false, true, true, true, true, true, false, },
			{ false, false, false, false, false, false, false, false, false, false, false, true, true, false, false, true, false, },
			{ false, true, true, true, true, true, true, true, true, true, true, true, true, false, true, true, false, },
			{ false, true, true, true, true, true, false, true, true, true, true, true, true, false, true, true, false, },
			{ false, true, true, true, true, true, false, true, true, true, true, true, true, false, true, true, false, },
			{ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false }
		};
	}

	public override void _Process(double delta)
	{
		MoveToTarget(delta);
	}

	private void MoveToTarget(double delta)
	{
		// move towards the target position
		if (Position != targetPosition * gridSize)
		{
			Vector2 direction = (targetPosition * gridSize - Position).Normalized();
			Position += direction * (float)delta * speed;

			// snap to target when close enough to avoid overshooting
			if (Position.DistanceTo(targetPosition * gridSize) < 1f)
			{
				Position = targetPosition * gridSize;
			}
		}
	}

	// set a new target position if valid (not blocked by table or wall)
	public void SetTargetPosition(Vector2 newTarget)
	{
		if (IsValidPosition(newTarget))
		{
			targetPosition = newTarget;
		}
	}

	// check if a target position is valid (i.e., not a table or wall cell)
	private bool IsValidPosition(Vector2 position)
	{
		int x = (int)position.X;
		int y = (int)position.Y;

		if (x < 0 || y < 0 || x >= grid.GetLength(0) || y >= grid.GetLength(1))
			return false;

		return !grid[x, y]; // return true if cell is walkable
	}
}
