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
	
	public class Enemy extends MovieClip
	{
		public var health:uint;
		public var damage:uint;
		public var isAttacking:Boolean;
		public var jumpHeight:uint;
		public var rangedWeapon:Weapon;
		public var physicalWeapon:Weapon;
		
		private var _bottomY:Number;
		private var _topY:Number;
		private var _leftX:Number;
		private var _rightX:Number;
		
		private var _rootDisplay:Object;
		
		public function Enemy() 
		{ 
			_bottomY = this.height;
			_topY = 0;
			_leftX = 0;
			_rightX = this.width;
		}
		
		public function set rootDisplay(pRootDisplay:Object):void
		{
			_rootDisplay = pRootDisplay;
		}
		
		public function update():void
		{
			
		}
		
		public function takeDamage(pDamage:uint):Boolean
		{
			if (this.health - pDamage <= 0)
			{
				this.health = 0;
				return true;
			}
			else
			{
				this.health -= pDamage;
			}
			return false;
		}
		
		public function checkCollision(pObject:Object):Boolean
		{
			return false;
		}
		
		private function moveLeft():void
		{
			
		}
		
		private function moveRight():void
		{
			
		}
				
		private function rangedAttack():void
		{
			
		}
		
		private function physicalAttack():void
		{
			
		}
		
		public function getPlayersXLocation():Number
		{
			return 1;
		}
		
		public function getPlayersYLocation():Number
		{
			return 1;
		}
		
		private function destroy():void
		{
			
		}
		
		public function spawn(pXLoc:Number, pYLoc:Number):void
		{
			
		}
		
		/**
		* Output text to the debugging console
		* @param arg The output to the debugger 
		*/
		private function errorDisplay(arg:*):void
		{
			_rootDisplay.debugger.appendText(arg + '\n');
			_rootDisplay.debugger.verticalScrollPosition = _rootDisplay.debugger.maxVerticalScrollPosition;
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
			errorDisplay("Jump Height: " + this.jumpHeight);
			errorDisplay("Ranged Weapon: " + rangedWeapon);
			errorDisplay("Physical Weapon: " + physicalWeapon);
			errorDisplay("X Location: " + this.x);
			errorDisplay("Y Location: " + this.y);
			errorDisplay("--------------------------------");
		}
		
		public function get bottomY():Number
		{
			return _bottomY;
		}
		
		public function get topY():Number
		{
			return _topY;
		}
		
		public function get leftX():Number
		{
			return _leftX;
		}
		
		public function get rightX():Number
		{
			return _rightX;
		}
	}
	
}