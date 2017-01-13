package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.fscommand;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	import flash.media.Sound;
	import flash.media.SoundChannel;

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

		public var collectedPointsForLeaderboard: Number = 0;

		private var timerDecreaseOxygen: Timer = new Timer(300, 0);


		private var collectRockSampleSound = new sound_collect_rock_sample();
		private var collectOxygenBottleSound = new sound_collect_oxygen_bottle();
		private var takeDamageSound = new sound_take_damage();
		private var soundtrack = new space_soundtrack();
		private var soundtrackSoundChannel = new SoundChannel();

		public function Main() {
			_instance = this;

			stop();

			loadConfigData();
			playSoundtrack();
		}

		private function loadConfigData() {
			var fileLoader: URLLoader = new URLLoader();
			fileLoader.load(new URLRequest("resources/config.xml"));
			fileLoader.addEventListener(Event.COMPLETE, processXMLData);
		}

		private function processXMLData(_event: Event) {
			configXML = new XML(_event.target.data);
		}
		
		private function playSoundtrack(){
			soundtrackSoundChannel = soundtrack.play();
			soundtrackSoundChannel.addEventListener(Event.SOUND_COMPLETE, replaySoundtrack);
		}
		
		private function replaySoundtrack(_event:Event){
			_event.currentTarget.removeEventListener(Event.SOUND_COMPLETE, replaySoundtrack);
			playSoundtrack();
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

		public function reachedRocket() {
			trace("Astronaut reached Rocket");
			clearLevel();
			gotoAndStop("finish");
		}

		public function collectedRockSample() {
			collectRockSampleSound.play();

			var currentPoints: Number = Number(collectedPoints.text);
			var newPoints: Number = currentPoints + 10;
			collectedPoints.text = String(newPoints);
			collectedPointsForLeaderboard = newPoints;
		}

		public function collectedOxygenBottle() {
			collectOxygenBottleSound.play();
			
			if (this.currentAstronautOxygen < 300) {
				this.currentAstronautOxygen += 30;
				this.oxygenBar.width = currentAstronautOxygen;
			}
		}

		public function setDecreaseOxygenTimer() {
			timerDecreaseOxygen.addEventListener("timer", decreaseOxygen);
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
			takeDamageSound.play();
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
			clearLevel();
			gotoAndStop("gameOver");
		}

		private function clearLevel() {

			for (var i: Number = this.Level.numChildren - 1; i > 0; i--) {
				var currentElement = this.Level.getChildAt(i);
				var currentElementType: String = getQualifiedClassName(currentElement);

				if ((currentElement is Platform) == false) {
					currentElement.removeFromStage();
				}
			}
			this.Level.removeFromStage();
			this.AstronautOnStage.removeFromStage();

			timerDecreaseOxygen.removeEventListener("timer", decreaseOxygen);
		}
	}
}