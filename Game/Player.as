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
		public var health:int;
		public var money:int;
		public var rangedWeapon:Weapon;
		public var physicalWeapon:Weapon;
		
		public var jumping:Boolean = false;
		var jumpSpeedMax:int;
		var jumpPercent:Number;
		var jumpQuickness:int;
		var jumpSpeed:Number;
		
		public var speed:int;
		
		private var _bottomY:Number;
		private var _topY:Number;
		private var _leftX:Number;
		private var _rightX:Number;
		
		public var levelHeight:int;
		public var levelWidth:int;
		
		private var image:Bitmap;
		
		private var xmlData:XML;
				
		private var rootDisplay:Object;
		
		public function Player(pRootDisplay:Object, xml:XML) 
		{ 
			rootDisplay = pRootDisplay;
			_bottomY = this.height;
			_topY = 0;
			_leftX = 0;
			_rightX = this.width;
			speed = 0;
			xmlData = xml;
			extractXML();
		}
		
		private function loadImage(callFunction:Function, file:String)
		{
			var loader:Loader = new Loader();
			var request:URLRequest;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, callFunction);
			request = new URLRequest(file);
			loader.load(request);
		}
		
		private function playerImageLoaded(event:Event):void
		{
			image = Bitmap(event.target.loader.content);
			this.addChild(image);
		}
		
		private function extractXML():void
		{
			speed = xmlData.player.speed;
			jumpSpeedMax = xmlData.player.jumpspeedmax;
			jumpPercent = xmlData.player.jumppercent;
			jumpQuickness = xmlData.player.jumpquickness;
			jumpSpeed = jumpSpeedMax;
			loadImage(playerImageLoaded, xmlData.player.file);
		}
		
		public function update():void
		{
	
		}
		
		public function moveLeft(time:Number):void 
		{
			this.x -= speed*time;
		}
		
		public function moveRight(time:Number):void 
		{
			this.x += speed*time;
		}
		
		public function jump(time:Number):void
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
				//if main hits the floor, then stop jumping
				//of course, we'll change this once we create the level
				if(this.y >= levelHeight - this.height)
				{
					jumping = false;
					this.y = levelHeight - this.height;
				}
			}
		}
		
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