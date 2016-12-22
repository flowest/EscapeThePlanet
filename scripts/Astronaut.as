package scripts {

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;

	import scripts.KeyInputHandler;
	import scripts.AnimationController;


	public class Astronaut extends AnimationController {

		private var stageReference: Stage;
		private var keyInputHandler: KeyInputHandler;

		private var isOnGround = false;

		private var scaleFactor = 0.25;

		private var speed: Number = 3;
		private var direction: Number = 1;
		private var deltaY: Number = 1;
		private var gravity: Number = 2;


		public function Astronaut(stageReference: Stage, xPos: Number, yPos: Number) {

			this.scaleX = scaleFactor;
			this.scaleY = scaleFactor;

			this.stageReference = stageReference;
			this.x = xPos;
			this.y = yPos;

			this.keyInputHandler = new KeyInputHandler(stageReference);
			this.addEventListener(Event.ENTER_FRAME, update);
			this.stageReference.addEventListener("spacebarPressedEvent", spacebarPressedHandler);
			
		}

		private function update(_event: Event) {
				moveAstronaut();
				doPhysics();
		}

		private function spacebarPressedHandler(_event: Event) {
			jumpAstronaut();
		}

		private function moveAstronaut() {

			if (keyInputHandler.isLeftKeyDown()) {
				doAnimation("Walk");

				direction = -1;
				this.x += speed * direction;
			} else if (keyInputHandler.isRightKeyDown()) {
				doAnimation("Walk");

				direction = 1;
				this.x += speed * direction;
			} else {
				doAnimation("Idle");
			}

			this.scaleX = direction * scaleFactor;
		}

		private function doPhysics() {
			if (isOnGround == false) {
				deltaY += gravity;
				this.y += deltaY;

				for (var i: Number = MovieClip(root).Level.numChildren - 1; i >= 0; i--) {
					while (MovieClip(root).Level.getChildAt(i).hitTestPoint(this.localToGlobal(new Point()).x, this.localToGlobal(new Point()).y, false)) {
						this.y -= 0.5;
						deltaY = 0;
						isOnGround = true;
					}
				}
			}
		}

		private function jumpAstronaut() {
			doAnimation("Jump");
		}
	}
}