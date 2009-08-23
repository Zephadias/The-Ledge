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
	import flash.events.KeyboardEvent;
	import flash.events.*;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import Engine.*;
	
	public class TheLedge extends MovieClip
	{
		/**
		* LEFT KEY CODE : 37
		*/
		private static const LEFT:uint = 37;
		
		/**
		* RIGHT KEY CODE : 39
		*/
		private static const RIGHT:uint = 39;
		
		/**
		* DOWN KEY CODE : 40
		*/
		private static const DOWN:uint = 40;
		
		/**
		* UP KEY CODE : 38
		*/
		private static const UP:uint = 38;
		
		/**
		* SPACEBAR KEY CODE : 32
		*/
		private static const SPACEBAR:uint = 32;
		
		/**
		* Z KEY CODE : 90
		*/
		private static const RANGED_ATTACK:uint = 90;
		
		/**
		* X KEY CODE : 88
		*/
		private static const PHYSICAL_ATTACK:uint = 88;
		
		/**
		* Game width in pixels : 400
		*/
		private static const GAME_WIDTH:uint = 600;
		
		/**
		* Game height in pixels : 550
		*/
		private static const GAME_HEIGHT:uint = 400;
		
		/**
		* The left button is being pressed or not
		*/
		private var leftButton:Boolean = false;
		
		/**
		* The right button is being pressed or not
		*/
		private var rightButton:Boolean = false;
		
		/**
		* The up button is being pressed or not
		*/
		private var upButton:Boolean = false;
		
		/**
		* The down button is being pressed or not
		*/
		private var downButton:Boolean = false;
		
		/**
		* The spacebar button is being pressed or not
		*/
		private var spacebarButton:Boolean = false;
		
		/**
		* The button is being pressed or not
		*/
		private var rangedAttackButton:Boolean = false;
		
		/**
		* The button is being pressed or not
		*/
		private var physicalAttackButton:Boolean = false;
		
		/**
		* The over all game time
		*/
		private var gameTime:uint;
		
		private var rootDisplay:Object = this;
		
		private var player:Player;
		
		public var xmlData:XML;
		
		public var level_1:Level;
		
		public function TheLedge() 
		{ 
			// Set debugger properties
			debuggerProperties(false);
						
			loadXML();
		}
		
		private function startGame():void
		{
			// The event listeners for the game
			this.addEventListener(Event.ENTER_FRAME, gameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keydownFunction);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyupFunction);
			
			
			level_1 = new Level(rootDisplay, "Level 1", xmlData);
			rootDisplay.addChildAt(level_1, 0);
			
			player = new Player(rootDisplay, xmlData);
			player.levelHeight = GAME_HEIGHT;
			player.levelWidth = GAME_WIDTH;
			
			level_1.attachPlayer(player, 100, GAME_HEIGHT-100);
			//errorDisplay(xmlData);
		}
		
		private function gameLoop(event:Event):void
		{
			if(gameTime == 0)
			{
				gameTime = getTimer();
			}
				
			var timeDifference:uint = getTimer() - gameTime;
			
			gameTime += timeDifference;
			
			var timeDecimal:Number = Number(timeDifference) * .01;
			
			if(leftButton)
			{
				player.moveLeft(timeDecimal);
			}
			
			if(rightButton)
			{
				player.moveRight(timeDecimal);
			}
			
			if(spacebarButton || player.jumping)
			{
				player.jump(timeDecimal);
			}
		}
		
		private function loadXML()
		{
			xmlData = new XML();
			var xmlURL:URLRequest = new URLRequest("GameVars.xml");
			var xmlLoader:URLLoader = new URLLoader(xmlURL);
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
		}
		
		function xmlLoaded(event:Event)
		{
			xmlData = XML(event.target.data);
			startGame();
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
		* Indent the debugger to make it easier to ready for specific lists
		* @param indentArg How many spaces to indent the debugger line
		*/
		private function indentDebugger(indentArg:uint):void
		{
			for(var i:int = 0; i < indentArg; i++)
			{
				rootDisplay.debugger.appendText(" ");
			}
		}
		
		/**
		* Set the debugger properties
		* @param isEditable Pass true if you want the debugger to be editable, false otherwise
		*/
		private function debuggerProperties(isEditable:Boolean)
		{
			rootDisplay.debugger.editable = isEditable;
		}
		
		/**
		* Everytime a key is lifted up, call this function
		* @param event The keyboard event
		*/
		public function keyupFunction(event:KeyboardEvent):void 
		{
			if(event.keyCode == LEFT)
			{
				leftButton = false;
			}
			else if(event.keyCode == RIGHT)
			{
				rightButton = false;
			}
	
			else if(event.keyCode == UP)
			{
				upButton = false;
			}
			
			else if(event.keyCode == DOWN)
			{
				downButton = false;
			}			
			
			else if(event.keyCode == SPACEBAR)
			{
				spacebarButton = false;
			}
			
			else if(event.keyCode == RANGED_ATTACK)
			{
				rangedAttackButton = false;
			}
			
			else if(event.keyCode == PHYSICAL_ATTACK)
			{
				physicalAttackButton = false;
			}
		
		}	
		
		/**
		* Everytime a key is pressed down, call this function
		* @param event The keyboard event
		*/
		public function keydownFunction(event:KeyboardEvent):void 
		{
			if(event.keyCode == LEFT)
			{
				errorDisplay("LEFT");
				leftButton = true;
			}
			else if(event.keyCode == RIGHT)
			{
				errorDisplay("RIGHT");
				rightButton = true;
			}
	
			else if(event.keyCode == UP)
			{
				errorDisplay("UP");
				upButton = true;
			}
			
			else if(event.keyCode == DOWN)
			{
				errorDisplay("DOWN");
				downButton = true;
			}			
			
			else if(event.keyCode == SPACEBAR && !spacebarButton)
			{
				spacebarButton = true;
				errorDisplay("Space Bar");
			}
			
			else if(event.keyCode == RANGED_ATTACK && !rangedAttackButton)
			{
				rangedAttackButton = true;
				errorDisplay("Ranged Attack");
			}
			
			else if(event.keyCode == PHYSICAL_ATTACK && !physicalAttackButton)
			{
				physicalAttackButton = true;
				errorDisplay("Physical Attack");
			}
		}
		
		/**
		* Shows all the children of a specific display object
		* @param dispObj The Display Object to print its children to the debugging console
		*/
		function showChildren(dispObj:*):void {
	
			for (var i:uint = 0; i <  dispObj.numChildren; i++) 
			{
				var obj:DisplayObject = dispObj.getChildAt(i)
				if (obj is DisplayObjectContainer) 
				{
					//errorDisplay(obj.name, obj);
					showChildren(obj);
				} 
				else 
				{
					errorDisplay(obj);
				}
			}
		}
		
		/**
		* Print all the Ledge info to the debugging console
		*/
		public function printInfo():void
		{
			errorDisplay("--------------------------------");
			errorDisplay("The Ledge Information");
			errorDisplay("--------------------------------");
		}
		
	
	}
	
}