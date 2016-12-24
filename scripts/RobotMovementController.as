package scripts {
	import flash.display.MovieClip;
	import flash.geom.Point;

	public class RobotMovementController extends MovieClip {

		private var robotToDoMovementOn: MovieClip;

		private var walkSpeed = 3;
		private var direction = 1;

		private var rightBound = stage.stageWidth - 100;
		private var leftBound = 100;

		public function RobotMovementController(robot: MovieClip) {
			this.robotToDoMovementOn = robot;
		}

		public function moveRobot(_isWalking: Boolean) {

			if (_isWalking) {
				var currentGlobalRobotXPos: Number = robotToDoMovementOn.localToGlobal(new Point()).x;
				var newGlobalRobotXPos: Number = currentGlobalRobotXPos + (walkSpeed * direction);

				if (newGlobalRobotXPos > rightBound || newGlobalRobotXPos < leftBound) {

					changeDirection();
				}

				robotToDoMovementOn.x += walkSpeed * direction;
			}

		}

		private function changeDirection(): void {

			direction *= -1;
			robotToDoMovementOn.scaleX *= -1;
		}

	}

}