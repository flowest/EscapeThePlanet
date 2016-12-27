﻿package scripts {
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.media.SoundChannel;
	import flash.media.Sound;

	public class BlackHoleController extends MovieClip {

		private var blackHoleSoundFile = new sound_black_hole();
		private var soundIsPlaying: Boolean = false;

		private var blackHoleSoundChannel = new SoundChannel();

		public function BlackHoleController() {
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(_event: Event) {
			if (this.hitTestObject(Main.instance.AstronautOnStage)) {
				if (soundIsPlaying == false) {
					soundIsPlaying = true;
					blackHoleSoundChannel = blackHoleSoundFile.play();
				}
				Main.instance.AstronautOnStage.setIsInBlackHoleRange(true);
				var thisGlobalPosition: Point = this.localToGlobal(new Point());
				var globalAstronautPosition: Point = Main.instance.AstronautOnStage.localToGlobal(new Point());

				pullAstronautToBlackHole(globalAstronautPosition, thisGlobalPosition);

				if (getDistance(thisGlobalPosition, globalAstronautPosition) < 50) {
					soundIsPlaying = false;
					blackHoleSoundChannel.stop();
					Main.instance.blackHoleCaughtAstronaut();
				}
			} else {
				soundIsPlaying = false;
				blackHoleSoundChannel.stop();
				Main.instance.AstronautOnStage.setIsInBlackHoleRange(false);
			}
		}

		private function pullAstronautToBlackHole(astronautPosition: Point, blackHolePosition: Point) {
			var xDirection;
			var yDirection;

			if (astronautPosition.y > blackHolePosition.y) {
				yDirection = -1;
			} else if (astronautPosition.y == blackHolePosition.y) {
				yDirection = 0;
			} else {
				yDirection = 1;
			}

			if (astronautPosition.x > blackHolePosition.x) {
				xDirection = -1;
			} else if (astronautPosition.y == blackHolePosition.y) {
				xDirection = 0;
			} else {
				xDirection = 1;
			}

			Main.instance.AstronautOnStage.y += yDirection;
			Main.instance.AstronautOnStage.x += xDirection;

		}

		private function getDistance(a: Point, b: Point): Number {
			var dx: Number = a.x - b.x;
			var dy: Number = a.y - b.y;
			return Math.sqrt(dx * dx + dy * dy);
		}

		public function removeFromStage() {
			removeEventListener(Event.ENTER_FRAME, update);
			this.parent.removeChild(this);
		}

	}

}