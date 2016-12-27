package scripts {

	import flash.display.MovieClip;
	import scripts.Physics;
	import flash.events.Event;

	public class GreenRobotController extends RobotMovementController {

		public function GreenRobotController() {
			super(this);
			addEventListener("greenRobotSpawnedEvent", robotSpawnedHandler);
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
			} else {
				super.setIsWalking(false);
				super.sendAnimationToAnimationController("Idle");
			}
		}
		
		public function removeFromStage(){
			super.removeEventListeners();
			removeEventListener("greenRobotSpawnedEvent", robotSpawnedHandler);
			this.parent.removeChild(this);
		}
	}

}