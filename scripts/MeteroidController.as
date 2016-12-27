package scripts {
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.Point;

	public class MeteroidController extends ApplyDamageController {


		private var meteroidSpeed: Number;
		private var moveDirection: Number;

		private var rotationSpeed: Number = Math.random() * 10;
		private var removeOffset: Number = 300;

		public function MeteroidController(xPos: Number, yPos: Number, _moveDirection: Number) {
			super();
			loadConfigData();

			this.x = xPos;
			this.y = yPos;
			this.moveDirection = _moveDirection;
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function loadConfigData() {
			var configData: XMLList = Main.instance.getMeteroidConfigData();

			this.meteroidSpeed = configData.MeteroidSpeed;
		}

		private function update(event: Event) {
			this.rotation += rotationSpeed;
			this.x += meteroidSpeed * moveDirection;

			if (this.localToGlobal(new Point()).x < -removeOffset || this.localToGlobal(new Point()).x > stage.stageWidth + removeOffset) {
				removeFromStage();
			}

			if (this.hitTestObject(Main.instance.AstronautOnStage)) {
				if (super.isAbleToDoDamage) {
					super.isAbleToDoDamage = false;
					Main.instance.meteroidHitAstronaut();
					super.timerIsAbleToDoDamage.start();
				}
			}
		}

		public function removeFromStage() {
			this.removeEventListener(Event.ENTER_FRAME, update);
			this.parent.removeChild(this);
		}
	}

}