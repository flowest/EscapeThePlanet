package {

	import flash.display.MovieClip;
	import flash.events.Event;
	
	import scripts.KeyInputHandler;
	import scripts.Astronaut;


	public class Main extends MovieClip {

		public var gameState: String = "home";
		

		public function Main() {
			stop();
			addButtonEventListeners();
		}
		
		private function addButtonEventListeners(): void {
			instructionsButton.addEventListener("click", gotoInstructions);
			homeButton.addEventListener("click", gotoHomeScreen);
			highscoreButton.addEventListener("click", gotoHighscore);
			startGameButton.addEventListener("click", startGame);
		}

		private function gotoInstructions(event: Event) {
			this.gameState = "instructions";
			gotoAndStop("instructions");
		}

		private function gotoHomeScreen(event: Event) {
			this.gameState = "home";
			gotoAndStop("home");
			addButtonEventListeners();
		}

		private function gotoHighscore(event: Event) {
			this.gameState = "highscore";
			gotoAndStop("highscore");
		}

		private function startGame(event: Event) {
			this.gameState = "gameStart";
			gotoAndStop("gameStart");
			setUpGame();
		}
		
		private function setUpGame(){
			//var astronaut = new Astronaut(stage,360,240);
			//stage.addChild(astronaut);
		}
	}

}