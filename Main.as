package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.fscommand;
	import flash.utils.Timer;

	public class Main extends MovieClip {

		private static var _instance: Main;
		public static function get instance(): Main {
			return _instance;
		}

		private var configXML: XML;

		private var initialAstronautHealth: Number;
		private var currentAstronautHealth: Number;

		private var initialAstronautOxygen: Number;
		private var currentAstronautOxygen: Number;

		private var timerDecreaseOxygen: Timer = new Timer(300, 0);

		public function Main() {
			_instance = this;

			stop();

			loadConfigData();
			timerDecreaseOxygen.addEventListener("timer", decreaseOxygen);
		}

		private function loadConfigData() {
			var fileLoader: URLLoader = new URLLoader();
			fileLoader.load(new URLRequest("resources/config.xml"));
			fileLoader.addEventListener(Event.COMPLETE, processXMLData);
		}

		private function processXMLData(_event: Event) {
			configXML = new XML(_event.target.data);
		}

		public function robotHitAstronaut() {
			trace("Robot hit Astronaut");
			applyDamageToAstronaut();
		}

		public function blackHoleCaughtAstronaut() {
			trace("caught by blackwhole");
			gameOver();
		}

		public function meteroidHitAstronaut() {
			trace("Astronaut hit Meteroid");
			applyDamageToAstronaut();
		}

		public function collectedRockSample() {
			var currentPoints: Number = Number(collectedPoints.text);
			var newPoints: Number = currentPoints + 10;
			collectedPoints.text = String(newPoints);
		}
		
		public function collectedOxygenBottle(){
			if(this.currentAstronautOxygen < 300){
				this.currentAstronautOxygen += 30;
				this.oxygenBar.width = currentAstronautOxygen;
			}
		}

		public function setAstronautHealth(_health: Number) {
			this.initialAstronautHealth = _health;
			this.currentAstronautHealth = _health;
			this.healthBar.width = _health;
		}

		public function setAstronautOxygen(_oxygen: Number) {
			this.initialAstronautOxygen = _oxygen;
			this.currentAstronautOxygen = _oxygen;
			this.oxygenBar.width = _oxygen;

			timerDecreaseOxygen.start();
		}

		public function getAstronautConfigData(): XMLList {
			return configXML.Astronaut;
		}

		public function getRobotConfigData(): XMLList {
			return configXML.Robot;
		}

		public function getMeteroidConfigData(): XMLList {
			return configXML.Meteroid;
		}

		private function applyDamageToAstronaut() {
			this.currentAstronautHealth -= this.initialAstronautHealth / 10;
			this.healthBar.width = this.currentAstronautHealth;

			if (this.currentAstronautHealth <= 0) {
				gameOver();
			}
		}

		private function decreaseOxygen(_event: Event) {
			this.currentAstronautOxygen -= this.initialAstronautOxygen / 500;
			this.oxygenBar.width = this.currentAstronautOxygen;

			if (this.currentAstronautOxygen <= 0) {
				gameOver();
			}
		}

		private function gameOver() {
			gotoAndStop("gameOver");
		}
	}
}