package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class Main extends MovieClip {

		private static var _instance: Main;
		public static function get instance(): Main {
			return _instance;
		}
		
		private var configXML:XML;

		public function Main() {
			_instance = this;
			
			stop();
			
			loadConfigData();
			addButtonEventListeners();
		}

		private function addButtonEventListeners() {
			instructionsButton.addEventListener("click", instructionsButtonClickedHander);
			highscoreButton.addEventListener("click", highscoreButtonClickedHander);
			backButton.addEventListener("click", backButtonClickedHander);
			startGameButton.addEventListener("click", startGameButtonClickedHander);
		}
		
		private function loadConfigData(){
			var fileLoader:URLLoader = new URLLoader();
			fileLoader.load(new URLRequest("resources/config.xml"));
			fileLoader.addEventListener(Event.COMPLETE,processXMLData);
		}
		
		private function processXMLData(_event:Event){
			configXML = new XML(_event.target.data);
		}

		private function instructionsButtonClickedHander(_event: Event) {
			gotoAndStop("instructions");
		}

		private function highscoreButtonClickedHander(_event: Event) {
			gotoAndStop("highscore");
		}

		private function backButtonClickedHander(_event: Event) {
			gotoAndStop("home");
			addButtonEventListeners();
		}

		private function startGameButtonClickedHander(_event: Event) {
			gotoAndStop("gameStart");
		}
		
		
		public function getAstronautConfigData():XMLList{
			return configXML.Astronaut;
		}
		
		public function getRobotConfigData():XMLList{
			return configXML.Robot;
		}
	}
}