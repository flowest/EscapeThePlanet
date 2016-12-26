package scripts {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;

	public class ApplyDamageController extends MovieClip {


		public var timerIsAbleToDoDamage: Timer = new Timer(1000, 0);

		public var isAbleToDoDamage: Boolean = true;

		public function ApplyDamageController() {

			timerIsAbleToDoDamage.addEventListener("timer", damageTimerElapsed);
		}

		private function damageTimerElapsed(_event: Event) {
			isAbleToDoDamage = true;
			this.timerIsAbleToDoDamage.stop();
		}

	}

}