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
		
		private var levelWidth:uint;
		private var levelHeight:uint;
		private var levelEdge:uint;
		
		public var pause:Boolean;
		
		private var rootDisplay:Object;
		
		private var xmlData:XML;
		
		private var player:Player;
		
		/**
		 * The level constructor.  Level's contain all the prop objects and background/foregrounds.
		 * 
		 * @param   pRootDisplay 	A link to the root display object of the game.
		 * @param   pLevelTitle  	The level title.
		 * @param   pXML         	The XML file that loads the variables of the level.
		 * @param   pLevelWidth  	The game width in pixels.
		 * @param   pLevelHeight  	The game height in pixels.
		 * @return  N/A
		 */
		
		public function Level(pRootDisplay:Object, pLevelTitle:String, pXML:XML, pLevelWidth:uint, pLevelHeight:uint) 
		{ 
			rootDisplay = pRootDisplay;
			_levelTitle = pLevelTitle;
			levelActive = false;
			propArray = new Array();
			xmlData = pXML;
			background_furthest = new Background(rootDisplay, "background_furthest", xmlData.level.background_1.file, xmlData.level.background_1.scrollspeed, levelWidth, levelHeight);
			background_closest = new Background(rootDisplay, "background_closest", xmlData.level.background_2.file, xmlData.level.background_2.scrollspeed, levelWidth, levelHeight);
			foreground_closest = new Background(rootDisplay, "foreground_closest", xmlData.level.foreground_1.file, xmlData.level.foreground_1.scrollspeed, levelWidth, levelHeight);
			foreground_furthest = new Background(rootDisplay, "foreground_furthest", xmlData.level.foreground_2.file, xmlData.level.foreground_2.scrollspeed, levelWidth, levelHeight);
			this.addChildAt(background_furthest, 0);
			this.addChildAt(background_closest, 1);
			this.addChildAt(foreground_closest, 2);
			
			levelWidth = pLevelWidth;
			levelHeight = pLevelHeight;
			levelEdge = pLevelWidth/2;
		}
		
		/**
		 * Attaches the player to the level at the supplied location.
		 * 
		 * @param   pPlayer The Player object.
		 * @param   xLoc    The X Location of where to attach the player at.
		 * @param   yLoc    The Y Location of where to attach the player at.
		 * @return  N/A
		 */
		
		public function attachPlayer(pPlayer:Player, xLoc:int, yLoc:int):void
		{
			this.addChildAt(pPlayer, 3);
			pPlayer.x = xLoc;
			pPlayer.y = yLoc;
			player = pPlayer;
			attachForeground(-100);
		}
		
		/**
		 * Attaches the foreground object that scrolls in front of the player.
		 * 
		 * @param   xLoc The X Location of where to initsiate this foreground object.
		 * @return  N/A
		 */
		
		public function attachForeground(xLoc:int):void
		{
			this.addChildAt(foreground_furthest, 4);
			foreground_furthest.x = xLoc;
		}
		
		/**
		 * Shake the screen for a visual effect.
		 * 
		 * @param   pLength The length of the screen shake in seconds.
		 * @param 	pMagnitude The strength of the screen shake.
		 * @return  N/A
		 */
		
		public function shakeScreen(pLength:uint, pMagnitude:uint):void
		{
			
		}
		
		/**
		 * Scrolls all the backgrounds and foregrounds to the left if the player is running to the right side of the screen.
		 * 
		 * @param   pTime The lag time.
		 * @return  N/A
		 */
		
		public function scrollBackgroundLeft(pTime:Number):void
		{
			if(player.x+player.width >= levelEdge)
			{
				background_furthest.scrollLeft(pTime);
				background_closest.scrollLeft(pTime);
				foreground_furthest.scrollLeft(pTime);
				foreground_closest.scrollLeft(pTime);
			}
		}
		
		/**
		 * Scrolls all the backgrounds and foregrounds to the right if the player is running to the left side of the screen.
		 * 
		 * @param   pTime The lag time.
		 * @return  N/A
		 */
		 
		public function scrollBackgroundRight(pTime:Number):void
		{
			if((player.x - player.width) <= 0)
			{
				background_furthest.scrollRight(pTime);
				background_closest.scrollRight(pTime);
				foreground_furthest.scrollRight(pTime);
				foreground_closest.scrollRight(pTime);
			}
		}
		
		/**
		 * An update function to call every frame.
		 * 
		 * @param   pTime The lag time.
		 * @return  N/A
		 */
		public function update(pTime:Number):void
		{
			
			
		}
		
		/**
		 * Remove a prop from the level.
		 * 
		 * @param   pItem The prop to remove from the level.
		 * @return  N/A
		 */
		
		public function removeProp(pItem:Object):void
		{
			
		}
		
		/**
		 * Add a prop to the game level.
		 * 
		 * @param   pItem The game prop to add to the level.
		 * @return  N/A
		 */
		
		public function addProp(pItem:Object):void
		{
			
		}
			
		/**
		 * Get the level's title.
		 * 
		 * @return  Returns the level's title.
		 */
		
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