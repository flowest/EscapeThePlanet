package scripts {

	import flash.display.MovieClip;
	import scripts.Physics;
	import flash.events.Event;

	public class GreenRobotController extends RobotMovementController {

		private var physicsController: Physics;
		private var animationController: AnimationController;

		public var isOnGround: Boolean = false;

		private var isWalking: Boolean = false;

		public function GreenRobotController() {
			super(this);
			physicsController = new Physics(MovieClip(this), MovieClip(this.parent));

			addEventListener("greenRobotSpawnedEvent", robotSpawnedHandler)
		}

		private function update(_event: Event) {
			physicsController.doPhyics();
			moveRobot(isWalking);
			checkForCollisionWithAstronaut();
		}

		private function robotSpawnedHandler(_event: Event) {
			animationController = new AnimationController(this.Robot_animated);
			addEventListener(Event.ENTER_FRAME, update);
		}

		public function getRandomAnimation() {
			var randomNumber: int = int(Math.random() * 100);

			if (randomNumber <= 70) {
				isWalking = true;
				animationController.doRobotAnimation("Walk");
			} else {
				isWalking = false;
				animationController.doRobotAnimation("Idle");
			}
		}
		
		private function checkForCollisionWithAstronaut(){
			if(this.hitTestObject(Main.instance.AstronautOnStage)){
				trace("Green Robot hit Astronaut");
			}
		}
	}

}