package {

	import flash.display.MovieClip;
	import flash.events.Event;

	public class Main extends MovieClip {
		

		public function Main() {
			stop();
			addButtonEventListeners();			
		}
		
		private function addButtonEventListeners(){
			instructionsButton.addEventListener("click",instructionsButtonClickedHander);
			highscoreButton.addEventListener("click",highscoreButtonClickedHander);
			backButton.addEventListener("click",backButtonClickedHander);
			startGameButton.addEventListener("click",startGameButtonClickedHander);
		}
		
		private function instructionsButtonClickedHander(_event:Event){
			gotoAndStop("instructions");
		}
		
		private function highscoreButtonClickedHander(_event:Event){
			gotoAndStop("highscore");
		}
		
		private function backButtonClickedHander(_event:Event){
			gotoAndStop("home");
			addButtonEventListeners();
		}
		
		private function startGameButtonClickedHander(_event:Event){
			gotoAndStop("gameStart");
		}
		
	}
}