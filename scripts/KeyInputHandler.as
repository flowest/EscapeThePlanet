package scripts {

	import flash.events.Event;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class KeyInputHandler {

		private var leftKeyDown: Boolean = false;
		private var rightKeyDown: Boolean = false;
		
		private var stageReference:Stage;

		public function KeyInputHandler(_stageReference: Stage) {
			stageReference = _stageReference;
			stageReference.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stageReference.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}

		private function keyDownHandler(_event: KeyboardEvent) {
			if (_event.keyCode == Keyboard.A || _event.keyCode == Keyboard.LEFT) {
				leftKeyDown = true;
			}

			if (_event.keyCode == Keyboard.D || _event.keyCode == Keyboard.RIGHT) {
				rightKeyDown = true;
			}

			if (_event.keyCode == Keyboard.SPACE) {
				var spacebarPressedEvent = new Event("spacebarPressedEvent",true);
				stageReference.dispatchEvent(spacebarPressedEvent);
			}
			
			if(_event.keyCode == Keyboard.ESCAPE){
				trace("esc was pressed");
			}
		}

		private function keyUpHandler(_event: KeyboardEvent) {
			if (_event.keyCode == Keyboard.A || _event.keyCode == Keyboard.LEFT) {
				leftKeyDown = false;
			}

			if (_event.keyCode == Keyboard.D || _event.keyCode == Keyboard.RIGHT) {
				rightKeyDown = false;
			}
		}

		public function isLeftKeyDown(): Boolean {
			return this.leftKeyDown;
		}

		public function isRightKeyDown(): Boolean {
			return this.rightKeyDown;
		}
	}
}