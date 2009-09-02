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
		
		private var _levelWidth:uint;
		private var _levelHeight:uint;
		private var _levelEdge:uint;
		private var scrollSpeed:uint;
		
		public var pause:Boolean;
		
		private var _gravity:Number = 0.004;
		
		private var rootDisplay:Object;
		
		private var xmlData:XML;
		
		private var player:Player;
		
		public var ledgeArray:Array;
		
		public var pledgetArray:Array;
		
		public var enemyArray:Array;
		
		public var moneyBagArray:Array;
		
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
		
		//public function Level(pRootDisplay:Object, pLevelTitle:String, pXML:XML, pLevelWidth:uint, pLevelHeight:uint) 
		public function Level(pRootDisplay:Object, pLevelTitle:String, pLevelWidth:uint, pLevelHeight:uint, pXML:XML) 
		{ 
			rootDisplay = pRootDisplay;
			_levelTitle = pLevelTitle;
			levelActive = false;
			propArray = new Array();
			ledgeArray = new Array();
			pledgetArray = new Array();
			enemyArray = new Array();
			moneyBagArray = new Array();
			xmlData = pXML;
			//background_furthest = new Background(rootDisplay, "background_furthest", xmlData.level.background_1.file, xmlData.level.background_1.scrollspeed, levelWidth, levelHeight);
			//background_closest = new Background(rootDisplay, "background_closest", xmlData.level.background_2.file, xmlData.level.background_2.scrollspeed, levelWidth, levelHeight);
			//foreground_closest = new Background(rootDisplay, "foreground_closest", xmlData.level.foreground_1.file, xmlData.level.foreground_1.scrollspeed, levelWidth, levelHeight);
			//foreground_furthest = new Background(rootDisplay, "foreground_furthest", xmlData.level.foreground_2.file, xmlData.level.foreground_2.scrollspeed, levelWidth, levelHeight);
			//this.addChildAt(background_furthest, 0);
			//this.addChildAt(background_closest, 1);
			//this.addChildAt(foreground_closest, 2);
			
			_levelWidth = pLevelWidth;
			_levelHeight = pLevelHeight;
			_levelEdge = pLevelWidth / 2;
			scrollSpeed = xmlData.level.scrollspeed;
		}
		
		public function addBackground(pLocation:String):void
		{
			for ( var i:int = rootDisplay.numChildren - 1; i >= 0; i-- )		
			{
				if (rootDisplay.getChildAt(i).toString() == "[object " + pLocation + "]")
				{
					errorDisplay("FOUND " + pLocation.toUpperCase() + "!!!");
					if ( pLocation == "background_furthest" )
					{
						//background_furthest = new Background(rootDisplay, pLocation, pObject, xmlData.level.background_furthest.scrollspeed, this);
						//background_furthest.setProperties(rootDisplay, pLocation, pObject, xmlData.level.background_furthest.scrollspeed, this);
					}
					else if ( pLocation == "background_closest" )
					{
						background_closest = rootDisplay.getChildAt(i);
						background_closest.setProperties(rootDisplay, "background_closest", xmlData.level.background_closest.scrollspeed, this);
					}
					else if ( pLocation == "foreground_closest" )
					{
						
					}
					else if ( pLocation == "foreground_furthest" )
					{
						
					}
				}
			}
		}
		
		public function findResources():void
		{
			errorDisplay('finding resources');
			for ( var i:int = rootDisplay.numChildren - 1; i >= 0; i-- )		
			{
				var tempItem = rootDisplay.getChildAt(i).valueOf();
				if (tempItem is Ledge)
				{
					ledgeArray.push(rootDisplay.getChildAt(i));
					//errorDisplay("FOUND A LEDGE");
				}
				if (tempItem is Pledget )
				{
					pledgetArray.push(rootDisplay.getChildAt(i));
					pledgetArray[pledgetArray.length - 1].rootDisplay = rootDisplay;
				}
				
				if ( tempItem is MoneyBag )
				{
					moneyBagArray.push(rootDisplay.getChildAt(i));
					moneyBagArray[moneyBagArray.length - 1].rootDisplay = rootDisplay;
				}
				
				if ( tempItem is Enemy )
				{
					enemyArray.push(rootDisplay.getChildAt(i));
					enemyArray[enemyArray.length - 1].rootDisplay = rootDisplay;
				}
			}
		}
		
		public function get gravity():Number
		{
			return _gravity;
		}
		
		public function get levelWidth():uint
		{
			return _levelWidth;
		}
		
		public function get levelHeight():uint
		{
			return _levelHeight;
		}
		
		public function get levelEdge():uint
		{
			return _levelEdge;
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
			rootDisplay.addChild(pPlayer);
			pPlayer.x = xLoc;
			pPlayer.y = yLoc;
			player = pPlayer;
			//attachForeground(-100);
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
		public function scrollLeft(pTime:Number):void
		{
			if(player.x+player.width/2 >= _levelEdge)
			{
				//background_furthest.scrollLeft(pTime);
				background_closest.scrollLeft(pTime);
				//foreground_furthest.scrollLeft(pTime);
				//foreground_closest.scrollLeft(pTime);
				
				for each (var ledge:Ledge in ledgeArray)
				{
					ledge.x -= scrollSpeed * pTime;
				}
				for each (var prop:Prop in pledgetArray)
				{
					prop.x -= scrollSpeed * pTime;
				}
				for each (var enemy:Enemy in enemyArray)
				{
					enemy.x -= scrollSpeed * pTime;
				}
				for each (var moneyBag:MoneyBag in moneyBagArray)
				{
					moneyBag.x -= scrollSpeed * pTime;
				}
			}
		
		}
		
		/**
		 * Scrolls all the backgrounds and foregrounds to the right if the player is running to the left side of the screen.
		 * 
		 * @param   pTime The lag time.
		 * @return  N/A
		 */
		public function scrollRight(pTime:Number):void
		{
			if((player.x - player.width) <= 0)
			{
				if (background_closest.x <= -5)
				{
				
					for each (var ledge:Ledge in ledgeArray)
					{
						ledge.x += scrollSpeed * pTime;
					}
					for each (var prop:Prop in pledgetArray)
					{
						prop.x += scrollSpeed * pTime;
					}
					for each (var enemy:Enemy in enemyArray)
					{
						enemy.x += scrollSpeed * pTime;
					}
					for each (var moneyBag:MoneyBag in moneyBagArray)
					{
						moneyBag.x += scrollSpeed * pTime;
					}
				}
				//background_furthest.scrollRight(pTime);
				background_closest.scrollRight(pTime);
				//foreground_furthest.scrollRight(pTime);
				//foreground_closest.scrollRight(pTime);
				
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
			for ( var i:int = pledgetArray.length - 1; i >= 0; i-- )
			{
				if (pledgetArray[i].checkCollisions(player))
				{
					rootDisplay.removeChild(pledgetArray[i]);
					pledgetArray.splice(i, 1);
					break;
				}
			}
			for ( i = moneyBagArray.length - 1; i >= 0; i-- )
			{
				if (moneyBagArray[i].checkCollisions(player))
				{
					rootDisplay.removeChild(moneyBagArray[i]);
					moneyBagArray.splice(i, 1);
					break;
				}
			}
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