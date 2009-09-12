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
		* Game height in pixels : 600
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
		
		/**
		* A link to the root display object. 
		*/
		private var rootDisplay:Object = this;
		
		/**
		* The main player of the game. 
		*/
		private var player:Player;
		
		/**
		* An XML Object used to input variables into the game at run-time. 
		*/
		public var xmlData:XML;
		
		/**
		* The first level. 
		*/
		public var level_1:Level;
		
		/**
		 * The Ledge constructor - Loads the debugger properties and loads the XML file.
		 * 
		 * @return  N/A
		 */
		
		public function TheLedge() 
		{ 
			// Set debugger properties
			debuggerProperties(false);	
			loadXML();
		}
		
		/**
		 * Adds the keyboard listeners and game loop event, creates a new game.
		 * 
		 * @return N/A  
		 */
		
		private function startGame():void
		{
			// The event listeners for the game
			this.addEventListener(Event.ENTER_FRAME, gameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keydownFunction);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyupFunction);
		
			level_1 = new Level(rootDisplay, "Level 1", GAME_WIDTH, GAME_HEIGHT, xmlData);
			rootDisplay.addChildAt(level_1, 0);
			level_1.addBackground("background_closest");
			level_1.addBackground("background_furthest");
			level_1.addBackground("foreground_closest");
			level_1.addBackground("foreground_furthest");
			player = new Player(rootDisplay, level_1, xmlData);
			level_1.attachPlayer(player, 0, 0);
			
			//errorDisplay(xmlData);
			level_1.findResources();
		}
		
		/**
		 * The Main Game Loop, this is called as fast as AS3 can.
		 * 
		 * @param   event The Enter Frame listener object.
		 * @return  N/A
		 */
		private function gameLoop(event:Event):void
		{
			if(gameTime == 0)
			{
				gameTime = getTimer();
			}
				
			var timeDifference:uint = getTimer() - gameTime;
			
			gameTime += timeDifference;
			
			var timeDecimal:Number = Number(timeDifference) * .01;
		
			player.update(timeDifference);
			level_1.update(timeDecimal);
			
			if(leftButton)
			{
				player.moveLeft(timeDecimal);
				level_1.scrollRight(timeDecimal);
			}
			
			if(rightButton)
			{
				player.moveRight(timeDecimal);
				level_1.scrollLeft(timeDecimal);
			}
			if (!rightButton)
			{
				//player.Edger.gotoAndPlay("StandingStill");
			}
			if (spacebarButton)
			{
				if (!player.inAir)
				{
					errorDisplay('JUMP');
					player.jump = true;
				}
			}
			if ( physicalAttackButton )
			{
				if (!player.isAttacking)
				{
					//errorDisplay("Is physical attacking...");
					player.physicalAttack();
				}
			}
			
			if ( rangedAttackButton )
			{
				if (!player.isAttacking)
				{
					//errorDisplay("is range attacking...");
					player.rangedAttack();
				}
			}
			
			if ( !rangedAttackButton )
			{
				if (player.rangedWeapon.dredgeActive)
				{
					rootDisplay.removeChild(player.rangedWeapon.dredgeCone);
					player.rangedWeapon.dredgeActive = false;
				}
			}
		}
		
		/**
		 * Loads the XML file, GameVars.xml.  Upon being loaded, the game will continue to load its additional components.
		 * 
		 * @return  N/A
		 */
		
		private function loadXML()
		{
			xmlData = new XML();
			var xmlURL:URLRequest = new URLRequest("GameVars.xml");
			var xmlLoader:URLLoader = new URLLoader(xmlURL);
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
		}
		
		/**
		 * When the XML file is loaded, this function is called internally.  
		 * 
		 * @param   event  Event Complete notification of the XML file is completly loaded.
		 * @return  N/A
		 */
		
		private function xmlLoaded(event:Event)
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
				player.isAttacking = false;
				
				if(player.rangedWeapon.startTimer != null)
					player.rangedWeapon.startTimer.reset();
			}
			
			else if(event.keyCode == PHYSICAL_ATTACK)
			{
				physicalAttackButton = false;
				player.isAttacking = false;
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
				//errorDisplay("LEFT");
				leftButton = true;
			}
			else if(event.keyCode == RIGHT)
			{
				//errorDisplay("RIGHT");
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