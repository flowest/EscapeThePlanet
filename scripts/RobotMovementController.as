﻿package scripts {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.Event;

	public class RobotMovementController extends MovieClip {

		private var robotToDoMovementOn: MovieClip;
		private var physicsController: Physics;
		private var animationController: AnimationController;

		private var walkSpeed: Number;
		private var jumpHeight;

		private var direction = 1;
		public var isOnGround: Boolean = false;
		private var isWalking: Boolean = false;

		private var rightBound = stage.stageWidth - 100;
		private var leftBound = 100;

		private var timerToChangeDirectionRandomly: Timer = new Timer(3000, 0);
		private var timerIsAbleToDoDamage: Timer = new Timer(1000, 0);

		private var isAbleToDoDamage: Boolean = true;

		public function RobotMovementController(robot: MovieClip) {
			loadConfigData();
			this.robotToDoMovementOn = robot;

			timerToChangeDirectionRandomly.addEventListener("timer", timerElapsedHandler);
			timerToChangeDirectionRandomly.start();

			timerIsAbleToDoDamage.addEventListener("timer", damageTimerElapsed);
		}

		private function loadConfigData() {
			var configData: XMLList = Main.instance.getRobotConfigData();

			this.walkSpeed = configData.WalkSpeed;
			this.jumpHeight = configData.JumpHeight;
		}

		public function getIsWalking(): Boolean {
			return this.isWalking;
		}

		public function setIsWalking(_value: Boolean): void {
			this.isWalking = _value;
		}

		public function setPhysicsController(_controller: Physics) {
			physicsController = _controller;
		}

		public function setAnimationController(_controller: AnimationController) {
			animationController = _controller;
		}

		private function moveRobot(_isWalking: Boolean) {

			if (_isWalking) {

				var currentGlobalRobotXPos: Number = robotToDoMovementOn.localToGlobal(new Point()).x;
				var newGlobalRobotXPos: Number = currentGlobalRobotXPos + (walkSpeed * direction);

				if (newGlobalRobotXPos > rightBound || newGlobalRobotXPos < leftBound) {

					changeDirection();
				}

				robotToDoMovementOn.x += walkSpeed * direction;
			}
		}

		private function changeDirection(): void {

			direction *= -1;
			robotToDoMovementOn.scaleX *= -1;
		}

		private function directionRandomlyChanged(): Boolean {
			var randomNumber: int = int(Math.random() * 100);

			if (randomNumber <= 30) {
				return true;
			} else {
				return false;
			}
		}

		private function timerElapsedHandler(_event: Event) {
			if (directionRandomlyChanged()) {
				changeDirection();
			}
		}

		public function initRobot(_event: Event) {
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(_event: Event) {
			physicsController.doPhyics();
			moveRobot(isWalking);
			checkForCollisionWithAstronaut();
		}

		private function checkForCollisionWithAstronaut() {
			if (this.hitTestObject(Main.instance.AstronautOnStage)) {


				if (isAbleToDoDamage) {
					isAbleToDoDamage = false;
					Main.instance.robotHitAstronaut();
					timerIsAbleToDoDamage.start();
				}
			}
		}

		private function damageTimerElapsed(_event: Event) {
			isAbleToDoDamage = true;
			timerIsAbleToDoDamage.stop();
		}

		public function sendAnimationToAnimationController(animation: String) {
			animationController.doRobotAnimation(animation);
		}

		public function triggerJumpOnPhysicsController() {
			physicsController.triggerJump(jumpHeight);
		}
	}

}