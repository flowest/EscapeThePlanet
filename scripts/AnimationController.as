package scripts {
	import flash.display.MovieClip;

	public class AnimationController extends MovieClip {
		
		private var currentAnimation = "";
		private var isJumping: Boolean = false;

		public function doAnimation(animation: String) {

			if (currentAnimation != animation && isJumping == false) {
				switch (animation) {
					case "Walk":
						gotoAndPlay(animation);
						currentAnimation = animation;
						break;

					case "Jump":
						gotoAndPlay(animation);
						currentAnimation = animation;
						isJumping = true;
						break;

					case "Idle":
						gotoAndPlay(animation);
						currentAnimation = animation;
						break;

					default:
						gotoAndPlay("Idle");
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