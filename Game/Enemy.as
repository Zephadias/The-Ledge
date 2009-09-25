/**********************************************************
/*
/*		Copyright: 2009 - Baygull Studios
/*		All Rights Reserved (R)
/*		
/*    	@Lead Programmer: Ryan Ploetz
/*
/*		@game: The Ledge
/*
/**********************************************************/

package Game {
	import flash.display.*;
	import Engine.*;
	import flash.geom.Point;
	
	public class Enemy extends MovieClip {
		protected static const WALKING_FRAME:String = 'walking';
		protected static const ATTACKING_FRAME:String = 'attacking';
		
		public var health:int = 100;
		protected static const DAMAGE:uint = 10;
		// Physics-related:
		private var speed:uint = 1;
		private var dx:Number = 0; // Change of X coord over time.
		private var dy:Number = 0; // Change of Y coord over time.
		private var inAir:Boolean;
		private var isJumping:Boolean = false;
		protected static const JUMP_SPEED:uint = 10;
		protected static const JUMP_HEIGHT:uint = 20;
		protected static const TIME_DIFFERENCE_MULTIPLER:uint = 10; // Multiplies time since last frame call to usable value.
		// Weaponry:
		public var physicalWeapon:Weapon = new ZombieTeeth();
		public var rangedWeapon:Weapon;
		private var isPhysicalAttack:Boolean;
		private var isRangeAttack:Boolean;
		
		//private var _bottomY:Number;
		//private var _topY:Number;
		//private var _leftX:Number;
		//private var _rightX:Number;
		
		//public var rootDisplay:Object;
		
		public function Enemy ()
		{
			//_bottomY = this.height;
			//_topY = 0;
			//_leftX = 0;
			//_rightX = this.width;
		}
		
		//public function set rootDisplay(pRootDisplay:Object):void
		//{
			//_rootDisplay = pRootDisplay;
		//}
		
		/**
		 * Action loop.
		 * Called by EnemyManager to make me run.
		 * @param pTime     Time since last frame call.
		 */
		public function update(pTime:Number):void
		{
			if (pTime == 0) return;
			var timeDifference:Number = pTime * TIME_DIFFERENCE_MULTIPLER;
			moveTowardsPlayer(timeDifference);
			// Handle vertical movement and platform detection
			dy += timeDifference * Level.GRAVITY;
			var verticalChange:Number = dy * timeDifference + timeDifference * Level.GRAVITY;
			verticalChange = verticalChange > JUMP_HEIGHT ? JUMP_HEIGHT : verticalChange;
			if (isJumping) {
				verticalChange = -JUMP_SPEED;
				dy = -JUMP_SPEED;
				isJumping = false;
			}
			this.inAir = true; // Default to 'not on a platform'. Checked against platform below.
			var newY:Number = y + verticalChange;
			var ledgeArray:Array = Level.getLedgeArray();
			for ( var i:int = ledgeArray.length - 1; i >= 0; i-- ) {
				var thisLedge:Ledge = ledgeArray[i];
				var withinLeft:Boolean = x+width/2 > thisLedge.x;
				var withinRight:Boolean = x-width/2 < thisLedge.x+thisLedge.width;
				if (withinLeft && withinRight) {
					var isAbove:Boolean = y <= thisLedge.y;
					var willBeBelow:Boolean = newY > thisLedge.y;
					if (isAbove && willBeBelow) {
						newY = thisLedge.y;
						dy = 0;
						inAir = false;
					}
				}
			}
			y = newY;
		}
		/**
		 * Decrement health and determine if dead.
		 * @param	pDamage Amount of damage.
		 * @return	true if dead, else false
		 */
		public function takeDamage(pDamage:int):Boolean
		{
			if (this.health - pDamage < 0)
			{
				this.health = 0;
				return true; // Character is dead, so ... do something about that, please!
			}
			else
			{
				this.health -= pDamage;
			}
			return false;
		}
		/**
		 * @param	pTime Length of time since last frame call.
		 */
		protected function moveTowardsPlayer(pTime:Number):void
		{
			var playerLocation:Point = Player.location;
			var isWithinPhysicalAttackRange:Boolean = Player.isTouching(this);// Actually, we need to get the player's width and height, so we can see, not just if we're touching him, but if our weapon is touching him. So, we'll need to calculate... or we could just use some point on our weapon and do a hit Test point with the player to see if a point at the tip of our weapon is touching the player.
			if (isWithinPhysicalAttackRange) {
				//.Attack.   
			}
			if (true) {
				if (playerLocation.x > this.x) {
					x += speed;
				} else {
					x -= speed;
				}
			}
			//var hittingLeftSideOfScreen:Boolean = (this.x - this.width/4 - (speed*pTime)) <= 0;
			//if(!hittingLeftSideOfScreen) {
				//x -= speed * pTime;
			//}
		}
		
		protected function moveRight():void
		{
			
			// Increment x value.
		}
		
		protected function rangedAttack():void
		{
			// THrow something.
		}
		
		protected function standStill():void {
			
		}
		
		
		
		protected function beAgressive():void {
			
		}
		protected function beNormal():void {
			
		}

		
		protected function physicalAttack():void
		{
			// Punch someone.
		}
		
		public function destroy():void
		{
			// Clear me.
			// Destructor.
		}
		

		/**
		* Output text to the debugging console
		* @param arg The output to the debugger 
		*/
		private function errorDisplay(arg:*):void
		{
			//rootDisplay.debugger.appendText(arg + '\n');
			//rootDisplay.debugger.verticalScrollPosition = rootDisplay.debugger.maxVerticalScrollPosition;
		}
		
		/**
		* Print all the Enemy info to the debugging console
		*/
		public function printInfo():void
		{
			errorDisplay("--------------------------------");
			errorDisplay("Enemy Information");
			errorDisplay("Health: " + this.health);
			//errorDisplay("Damage: " + this.damage);
			//errorDisplay("Jump Height: " + this.jumpHeight);
			errorDisplay("Ranged Weapon: " + rangedWeapon);
			errorDisplay("Physical Weapon: " + physicalWeapon);
			errorDisplay("X Location: " + this.x);
			errorDisplay("Y Location: " + this.y);
			errorDisplay("--------------------------------");
		}
		
		//public function get bottomY():Number
		//{
			//return _bottomY;
		//}
		//
		//public function get topY():Number
		//{
			//return _topY;
		//}
		//
		//public function get leftX():Number
		//{
			//return _leftX;
		//}
		//
		//public function get rightX():Number
		//{
			//return _rightX;
		//}
	}
	
}