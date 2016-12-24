package scripts {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.Event;

	public class RobotMovementController extends MovieClip {

		private var robotToDoMovementOn: MovieClip;

		private var walkSpeed: Number;
		private var direction = 1;

		private var rightBound = stage.stageWidth - 100;
		private var leftBound = 100;

		private var timerToChangeDirectionRandomly: Timer = new Timer(3000, 0);
		
		public function RobotMovementController(robot: MovieClip) {
			loadConfigData();
			this.robotToDoMovementOn = robot;

			timerToChangeDirectionRandomly.addEventListener("timer", timerElapsedHandler);
			timerToChangeDirectionRandomly.start();
		}

		private function loadConfigData() {
			var configData: XMLList = Main.instance.getRobotConfigData();

			this.walkSpeed = configData.WalkSpeed;
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

		private function directionRandomlyChanged(): Boolean {
			var randomNumber: int = int(Math.random() * 100);

			if (randomNumber <= 30) {
				return true;
			} else {
				return false;
			}
		}

		private function timerElapsedHandler(_event: Event) {
			if (directionRandomlyChanged()) {
				changeDirection();
			}
		}

	}

}