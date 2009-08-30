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
	import flash.display.BitmapData;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import Engine.*;
	
	public class Player extends MovieClip
	{
		public var health:uint;
		public var money:uint;
		public var rangedWeapon:Weapon;
		public var physicalWeapon:Weapon;
		
		//private var gravity:Number = .004;
		
		public var jumping:Boolean = false;
		private var jumpSpeed:Number;
		
		public var speed:uint;
		private var dx:Number;
		private var dy:Number;
		public var inAir:Boolean;
		
		private var _bottomY:Number;
		private var _topY:Number;
		private var _leftX:Number;
		private var _rightX:Number;
			
		private var image:Bitmap;
		
		private var xmlData:XML;
		public var jump:Boolean;
				
		private var level:Level;
		private var ledgeArray:Array;
		
		private var rootDisplay:Object;
		
		//public function Player(pRootDisplay:Object, xml:XML) 
		public function Player(pRootDisplay:Object, pLevel:Level, xml:XML)
		{ 
			rootDisplay = pRootDisplay;
			_bottomY = this.height;
			_topY = 0;
			_leftX = 0;
			_rightX = this.width;
			dx = 0.0;
			dy = 0.0;
			inAir = false;
			jump = false;
			level = pLevel;
			ledgeArray = level.ledgeArray;
			xmlData = xml;
			//rootDisplay.addChild(this);
			extractXML();
		}
		
		/*private function loadImage(callFunction:Function, file:String)
		{
			var loader:Loader = new Loader();
			var request:URLRequest;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, callFunction);
			request = new URLRequest(file);
			loader.load(request);
		}*/
		
		/*private function playerImageLoaded(event:Event):void
		{
			image = Bitmap(event.target.loader.content);
			this.addChild(image);
		}*/
		
		private function extractXML():void
		{
			speed = xmlData.player.speed;
			jumpSpeed = xmlData.player.jumpspeed;
			//loadImage(playerImageLoaded, xmlData.player.file);
		}
		
		public function update(pTime:Number):void
		{
			if (pTime < 1) return;
			
			var verticalChange:Number = this.dy * pTime + pTime * level.gravity;
			
			if (verticalChange > 15.0)
				verticalChange  = 15.0;
			this.dy += pTime * level.gravity;
			
			if (this.jump)
			{
				this.jump = false;
				this.dy = -this.jumpSpeed;
				verticalChange = -this.jumpSpeed;
			}
			
			this.inAir = true;
			
			var newY:Number = this.y + verticalChange;
			
			for ( var i:int = ledgeArray.length - 1; i >= 0; i-- )
			{
				if ((this.x+this.width/2 > ledgeArray[i].x) && ((this.x - this.width/2) < (ledgeArray[i].x + ledgeArray[i].width))) 
				{
					if (( this.y  <= ledgeArray[i].y ) && newY > ledgeArray[i].y) 
					{
						newY = ledgeArray[i].y;
						this.dy = 0;
						this.inAir = false;	
					}
				}
			}
			
			this.y = newY;
		}
		
		/**
		 * Move the player to the left.
		 * 
		 * @param   pTime The time since this update was last called.
		 * @return  
		 */
		
		public function moveLeft(pTime:Number):void 
		{
			if( !( (this.x - (speed*pTime)) <= 0))
			{
				this.x -= speed*pTime;
			}
		}
		
		/**
		 * Move the player to the right.
		 * 
		 * @param   pTime The time since this update was last called.
		 * @return  N/A
		 */
		
		public function moveRight(pTime:Number):void 
		{
			if( !( (this.x + (this.width/2) + (speed*pTime) ) >= (level.levelWidth - level.levelWidth/4) ) )
			{
				this.x += speed*pTime;
			}
		}
		
		/**
		 * Make the player jump.  Use Jumpspeedmax, jumpquickness, jumppercent in the GameVars.xml file.
		 * 
		 * @return  N/A
		 */
		/*
		public function jump():void
		{
			if(!jumping)
			{
				jumping = true;
				jumpSpeed = -jumpSpeedMax;
				this.y += jumpSpeed;
			} 
			else 
			{
				if(jumpSpeed < 0)
				{
					jumpSpeed *= jumpPercent;
					if(jumpSpeed > -jumpQuickness)
					{
						jumpSpeed = -jumpSpeed;
					}
				}
				if(jumpSpeed > 0 && jumpSpeed <= jumpSpeedMax)
				{
					jumpSpeed *= 1 + jumpSpeedMax/50;
				}
				this.y += jumpSpeed;
				
				
				
				if(this.y >= levelHeight - this.height)
				{
					jumping = false;
					this.y = levelHeight - this.height;
				}
			}
		}
		*/
		public function checkCollision(pObject:Object):Boolean
		{
			return false;
		}
		
		public function rangedAttack():void
		{
			
		}
		
		public function physicalAttack():void
		{
			
		}
		
		public function spawn(pXLoc:Number, pYLoc:Number):void
		{
			this.x = pXLoc;
			this.y = pYLoc;
			rootDisplay.addChild(this);
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
		* Print all the Player info to the debugging console
		*/
		public function printInfo():void
		{
			errorDisplay("--------------------------------");
			errorDisplay("Player Information");
			errorDisplay("Health: " + this.health);
			errorDisplay("Money: " + money);
			//errorDisplay("Ranged Weapon: " + rangedWeapon.toString());
			//errorDisplay("Physical Weapon: " + physicalWeapon.toString());
			errorDisplay("Movement Speed: " + speed);
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