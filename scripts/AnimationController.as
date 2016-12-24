package scripts {

	import flash.display.MovieClip;

	public class AnimationController extends MovieClip {

		private var currentAnimation = "";
		private var isJumping: Boolean = false;

		private var animatedObject: MovieClip;

		public function AnimationController(_animatedObject: MovieClip) {
			this.animatedObject = _animatedObject;
		}

		public function doAstronautAnimation(animation: String) {

			if (currentAnimation != animation && isJumping == false) {
				selectAnimation(animation);
			}
		}

		public function doRobotAnimation(animation: String) {
			if (isJumping == false) {
				selectAnimation(animation);
			}
		}

		private function selectAnimation(animation: String) {
			switch (animation) {
				case "Walk":
					animatedObject.gotoAndPlay(animation);
					currentAnimation = animation;
					break;

				case "Jump":
					animatedObject.gotoAndPlay(animation);
					currentAnimation = animation;
					isJumping = true;
					break;

				case "Idle":
					animatedObject.gotoAndPlay(animation);
					currentAnimation = animation;
					break;

				default:
					animatedObject.gotoAndPlay("Idle");
					currentAnimation = "Idle";
					break;
			}
		}

		public function jumpEnded(): void {
			this.isJumping = false;
		}

		public function getCurrentAnimation(): String {
			return currentAnimation;
		}

	}

}