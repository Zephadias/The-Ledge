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

package Engine 
{
	import flash.display.*;
	import Game.*;
	
	public class Prop extends MovieClip
	{
		public var ID:int;
		private var _bottomY:Number;
		private var _topY:Number;
		private var _leftX:Number;
		private var _rightX:Number;
		private var rootDisplay:Object;
		
		public function Prop() 
		{ 
			_bottomY = this.height;
			_topY = 0;
			_leftX = 0;
			_rightX = this.width;
		}
		
		public function update():void
		{

		}
		
		public function checkCollisions(pPlayer:Player):Boolean
		{
			return false;
		}
		
		public function pickUp():Prop
		{
			errorDisplay('Picked Up prop');
			return this;
		}
		
		public function spawn(pXloc:Number, pYLoc:Number):void
		{
			
		}
		
		public function setLocation(pXLoc:Number, pYLoc:Number):void
		{
			this.x = pXLoc;
			this.y = pYLoc;
		}
		
		/**
		* Output text to the debugging console
		* @param arg The output to the debugger 
		*/
		protected function errorDisplay(arg:*):void
		{
			rootDisplay.debugger.appendText(arg + '\n');
			rootDisplay.debugger.verticalScrollPosition = rootDisplay.debugger.maxVerticalScrollPosition;
		}
		
		/**
		* Print all the Prop info to the debugging console
		*/
		protected function printInfo():void
		{
			errorDisplay("--------------------------------");
			errorDisplay("Prop Information");
			errorDisplay("ID: " + ID);
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