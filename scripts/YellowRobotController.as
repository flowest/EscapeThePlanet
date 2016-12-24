package scripts {

	import flash.display.MovieClip;
	import scripts.Physics;
	import flash.events.Event;

	public class YellowRobotController extends RobotMovementController {
		public function YellowRobotController() {
			super(this);
			addEventListener("yellowRobotSpawnedEvent", robotSpawnedHandler)
		}

		private function robotSpawnedHandler(_event: Event) {
			super.setAnimationController(new AnimationController(this.Robot_animated));
			super.setPhysicsController(new Physics(MovieClip(this), MovieClip(this.parent)));
			super.initRobot(_event);
		}

		public function getRandomAnimation() {
			var randomNumber: int = int(Math.random() * 100);

			if (randomNumber <= 70) {
				super.setIsWalking(true);
				super.sendAnimationToAnimationController("Walk");
				super.triggerJumpOnPhysicsController();
			} else {
				super.setIsWalking(false);
				super.sendAnimationToAnimationController("Idle");
			}
		}

	}

}