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
	
	public class Level extends MovieClip
	{
		private var _levelTitle:String;
		public var levelActive:Boolean;
		private var propArray:Array;
		
		private var background_furthest:Background;
		private var background_closest:Background;
		private var foreground_closest:Background;
		private var foreground_furthest:Background;
		
		public var pause:Boolean;
		
		private var rootDisplay:Object;
		
		private var xmlData:XML;
		
		public function Level(pRootDisplay:Object, pLevelTitle:String, pXML:XML) 
		{ 
			rootDisplay = pRootDisplay;
			_levelTitle = pLevelTitle;
			levelActive = false;
			propArray = new Array();
			xmlData = pXML;
			background_furthest = new Background(rootDisplay, "background_furthest", xmlData.level.background_1.file, xmlData.level.background_1.scrollspeed);
			background_closest = new Background(rootDisplay, "background_closest", xmlData.level.background_2.file, xmlData.level.background_2.scrollspeed);
			foreground_closest = new Background(rootDisplay, "foreground_closest", xmlData.level.foreground_1.file, xmlData.level.foreground_1.scrollspeed);
			foreground_furthest = new Background(rootDisplay, "foreground_furthest", xmlData.level.foreground_2.file, xmlData.level.foreground_2.scrollspeed);
			this.addChildAt(background_furthest, 0);
			this.addChildAt(background_closest, 1);
			this.addChildAt(foreground_closest, 2);
			//this.addChild(foreground_furthest);
		}
		
		public function attachPlayer(pPlayer:Player, xLoc:int, yLoc:int):void
		{
			this.addChildAt(pPlayer, 3);
			pPlayer.x = xLoc;
			pPlayer.y = yLoc;
			attachForeground();
		}
		
		public function attachForeground():void
		{
			this.addChildAt(foreground_furthest, 4);
			foreground_furthest.x = -100;
		}
		
		public function shakeScreen(pLength:int):void
		{
			
		}
		
		public function removeProp(pItem:Object):void
		{
			
		}
		
		public function addProp(pItem:Object):void
		{
			
		}
				
		public function get levelTitle():String
		{
			return _levelTitle;
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
		* Print all the Level info to the debugging console
		*/
		public function printInfo():void
		{
			errorDisplay("--------------------------------");
			errorDisplay("Level Information");
			errorDisplay("X Location: " + this.x);
			errorDisplay("Y Location: " + this.y);
			errorDisplay("--------------------------------");
		}
	}
	
	
	
}