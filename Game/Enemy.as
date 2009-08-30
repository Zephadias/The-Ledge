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
		
		private var rootDisplay:MovieClip;
		
		public function Enemy(pRootDisplay:MovieClip) 
		{ 
			rootDisplay = pRootDisplay;
				
			_bottomY = this.height;
			_topY = 0;
			_leftX = 0;
			_rightX = this.width;
		}
		
		public function update():Void
		{
			
		}
		
		public function checkCollision(pObject:Object):Boolean
		{
			
		}
		
		private var moveLeft():Void
		{
			
		}
		
		private var moveRight():Void
		{
			
		}
		
		private var jump():Void
		{
			
		}
		
		private var rangedAttack():Void
		{
			
		}
		
		private var physicalAttack():Void
		{
			
		}
		
		public var getPlayersXLocation():Number
		{
			
		}
		
		public var getPlayersYLocation():Number
		{
			
		}
		
		private var destroy():Void
		{
			
		}
		
		public var spawn(pXLoc:Number, pYLoc:Number):Void
		{
			
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
			errorDisplay("Jump Height: " + this.jumpHeight);
			errorDisplay("Ranged Weapon: " + rangedWeapon.toString());
			errorDisplay("Physical Weapon: " + physicalWeapon.toString());
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