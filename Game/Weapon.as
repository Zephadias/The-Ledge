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
		
	public class Weapon
	{
		
		public var damage:int;
		
		protected var rootDisplay:Object;
	
		protected var player:Player;
		
		public function Weapon() 
		{ 
			
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
		* Print all the Weapon info to the debugging console
		*/
		public function printInfo():void
		{
			errorDisplay("--------------------------------");
			errorDisplay("Weapon Information");
			errorDisplay("Damage: " + damage);
			errorDisplay("--------------------------------");
		}
	
	}
	
}