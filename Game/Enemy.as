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

package Game 
{
	import flash.display.*;
	import Engine.*;
	import flash.geom.Point;
	
	public class Enemy extends MovieClip
	{
		protected static const WALKING_FRAME:String = 'walking'; 
		protected static const ATTACKING_FRAME:String = 'attacking'; 
		public var health:int;
		public var damage:int;
		private var isPhysicalAttack:Boolean;
		private var isRangeAttack:Boolean;
		//public var jumpHeight:uint;
		public var rangedWeapon:Weapon;
		public var physicalWeapon:Weapon;
		public var speed:int;
		
		//private var _bottomY:Number;
		//private var _topY:Number;
		//private var _leftX:Number;
		//private var _rightX:Number;
		
		public var rootDisplay:Object;
		
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
		
		public function update():void
		{
			
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
		
		protected function moveLeft():void
		{
			// Decrement x value.
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
		 * My own action loop.
		 * @usage Called by EnemyManager whenever I'm running.
		 */
		public function runAI (pTime:Number):void {
			//errorDisplay(pTime);
		}
		/**
		* Output text to the debugging console
		* @param arg The output to the debugger 
		*/
		private function errorDisplay(arg:*):void
		{
			rootDisplay.debugger.appendText(arg + '\n');
			rootDisplay.debugger.verticalScrollPosition = rootDisplay.debugger.maxVerticalScrollPosition;
		}
		
		/**
		* Print all the Enemy info to the debugging console
		*/
		public function printInfo():void
		{
			errorDisplay("--------------------------------");
			errorDisplay("Enemy Information");
			errorDisplay("Health: " + this.health);
			errorDisplay("Damage: " + this.damage);
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