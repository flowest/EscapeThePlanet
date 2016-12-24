package scripts {
	import flash.display.MovieClip;
	import flash.geom.Point;

	public class Physics{

		private var objectToDoPhysicsOn: MovieClip;
		private var levelToDoPhysicsOn: MovieClip;
		
		private var fallSpeedLimit = 10;

		private var deltaY: Number = 1;
		private var gravity: Number = 1;

		public function Physics(_objectToDoPhysicsOn: MovieClip, _levelToDoPhysicsOn: MovieClip) {
			this.objectToDoPhysicsOn = _objectToDoPhysicsOn;
			this.levelToDoPhysicsOn = _levelToDoPhysicsOn;
		}

		public function doPhyics() {
			if(deltaY < fallSpeedLimit){
				deltaY += gravity;
			}
			objectToDoPhysicsOn.y += deltaY;

			for (var i: Number = levelToDoPhysicsOn.numChildren - 1; i >= 0; i--) {

				var currentElementInLevel = levelToDoPhysicsOn.getChildAt(i);

				while (currentElementInLevel.hitTestPoint(objectToDoPhysicsOn.localToGlobal(new Point()).x, objectToDoPhysicsOn.localToGlobal(new Point()).y, true) && (currentElementInLevel is Platform || currentElementInLevel is Floor)) {
					objectToDoPhysicsOn.y -= 1;
					deltaY = 0;
					objectToDoPhysicsOn.isOnGround = true;
				}
			}

		}
		
		public function triggerJump(_jumpHeight:Number){
			deltaY -= _jumpHeight;
		}

	}

}