package scripts {

	import flash.display.MovieClip;

	public class AnimationController {
				
		private var currentAnimation = "";
		private var isJumping: Boolean = false;

		private var animatedObject: MovieClip;

		public function AnimationController(_animatedObject: MovieClip) {
			this.animatedObject = _animatedObject;
		}

		public function doAnimation(animation: String) {

			if (currentAnimation != animation && isJumping == false) {
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

		}
		
		public function jumpEnded(){
			this.isJumping = false;
		}

	}

}