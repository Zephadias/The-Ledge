﻿/**********************************************************
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
	
	private var weaponType:String;
	private var _damage:int;
	
	private var rootDisplay:Object;
	
	public class Weapon
	{
		public function Weapon(rootMC:Object, pType:String, pDamage:int) 
		{ 
			rootDisplay = rootMC;
			weaponType = pType;
			damage = pDamage;
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
		* Print all the Weapon info to the debugging console
		*/
		public function printInfo():void
		{
			errorDisplay("--------------------------------");
			errorDisplay("Weapon Information");
			errorDisplay("--------------------------------");
		}
		
		
		public funcction get damage():int
		{
			return _damage;
		}
	
	}
	
}