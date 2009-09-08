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
	import flash.utils.Timer;
	import flash.events.*;
	
	public class Player extends MovieClip
	{
		public const HEALTH_CONST:uint = 5475;
		public const MONEY_CONST:uint = 10000;
		public var health:uint;
		public var money:uint;
		public var rangedWeapon:Dredge;
		public var physicalWeapon:SledgeHammer;
			
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
				
		public var level:Level;
		private var ledgeArray:Array;
		
		public var isAttacking:Boolean;
		public var startTimer:Timer;
		
		public var courtDocuments:uint = 0;
		
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
			isAttacking = false;
			physicalWeapon = new SledgeHammer(rootDisplay, 25, this);
			rangedWeapon = new Dredge(rootDisplay, 25, this);
			//standStill();
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
			health = xmlData.player.health;
			money = xmlData.player.money;
			level.statisticsGenerator.moneyCollected += money;
			//loadImage(playerImageLoaded, xmlData.player.file);
		}
		
		public function standStill():void
		{
			//this.Edger.gotoAndPlay("StandingStill");
		}
		
		public function update(pTime:Number):void
		{
			//this.Edger.gotoAndPlay("StandingStill");
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
			if (rangedWeapon.dredgeActive)
				rangedWeapon.dredgeCone.y = this.y - this.height - this.height / 4;
		}
		
		/**
		 * Move the player to the left.
		 * 
		 * @param   pTime The time since this update was last called.
		 * @return  
		 */
		
		public function moveLeft(pTime:Number):void 
		{
			if( !( (this.x - this.width/4 - (speed*pTime)) <= 0))
			{
				this.x -= speed * pTime;
				if(rangedWeapon.dredgeActive)
					rangedWeapon.dredgeCone.x -= speed * pTime;
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
				this.x += speed * pTime;
				if(rangedWeapon.dredgeActive)
					rangedWeapon.dredgeCone.x += speed * pTime;
			}
			/*
			if ( this.Edger.currentFrame > 33 )
			{
				errorDisplay(this.Edger.currentFrame);
				this.Edger.gotoAndPlay("RunStart");
			}
			*/
		}
		
		public function checkCollision(pObject:Object):Boolean
		{
			return false;
		}
		
		/*private function rangedAttackTimer(event:TimerEvent):void
		{
			errorDisplay("ranged attack timer");
			
			
			for ( var i:int = tempEnemyArray.length - 1; i >= 0; i-- )
			{
				if (this.hitTestObject(tempEnemyArray[i]) )
				{
					if (level.enemyArray[tempEnemyArrayCounter[i]].takeDamage(rangedWeapon.damage))
					{
						var tempTotal = Math.floor(Math.random() * 4);
					
						var moneyProp:MoneyProp;
						for ( var k:uint = 0; k <= tempTotal; k++)
						{
							moneyProp = new MoneyProp();
							moneyProp.level = level;
							moneyProp.x = level.enemyArray[tempEnemyArrayCounter[i]].x ;
							moneyProp.y = level.enemyArray[tempEnemyArrayCounter[i]].y - level.enemyArray[tempEnemyArrayCounter[i]].height;
							moneyProp.rootDisplay = rootDisplay;
							rootDisplay.addChild(moneyProp);
							level.moneyPropArray.push(moneyProp);
						}
						
						rootDisplay.removeChild(level.enemyArray[tempEnemyArrayCounter[i]]);
						level.enemyArray.splice(tempEnemyArrayCounter[i], 1);
						
					}
					else
					{
						errorDisplay('Enemy took damage.  Health is now: ' + level.enemyArray[tempEnemyArrayCounter[i]].health);
					}
				}
			}
			tempEnemyArray.splice(0);
			tempEnemyArrayCounter.splice(0);		
			
		}
		*/
		public function rangedAttack():void
		{
			isAttacking = true;
			
			rangedWeapon.activate();
		}
		
		public function physicalAttack():void
		{
			isAttacking = true;
			this.gotoAndPlay("Physical");
		
			var tempEnemyArray:Array = new Array();
			var tempEnemyArrayCounter:Array = new Array();
			for ( var j:int = level.enemyArray.length - 1; j >= 0; j-- )
			{
				if ( level.enemyArray[j].x <= this.x + 125 && level.enemyArray[j].x + 125 >= this.x)
				{
					tempEnemyArray.push(level.enemyArray[j]);
					tempEnemyArrayCounter.push(j);
				}
			}
			
			for ( var i:int = tempEnemyArray.length - 1; i >= 0; i-- )
			{
				if (this.hitTestObject(tempEnemyArray[i]) && tempEnemyArray[i].x > (this.x+(this.width/4)) )
				{
					if (level.enemyArray[tempEnemyArrayCounter[i]].takeDamage(physicalWeapon.damage))
					{
						var tempTotal = Math.floor(Math.random() * 4);
						//var tempTotal = 50;
						var moneyProp:MoneyProp;
						for ( var k:uint = 0; k <= tempTotal; k++)
						{
							moneyProp = new MoneyProp();
							moneyProp.level = level;
							moneyProp.x = level.enemyArray[tempEnemyArrayCounter[i]].x ;
							moneyProp.y = level.enemyArray[tempEnemyArrayCounter[i]].y - level.enemyArray[tempEnemyArrayCounter[i]].height;
							moneyProp.rootDisplay = rootDisplay;
							rootDisplay.addChild(moneyProp);
							level.moneyPropArray.push(moneyProp);
						}
						
						rootDisplay.removeChild(level.enemyArray[tempEnemyArrayCounter[i]]);
						level.enemyArray.splice(tempEnemyArrayCounter[i], 1);
						
					}
					else
					{
						errorDisplay('Enemy took damage.  Health is now: ' + level.enemyArray[tempEnemyArrayCounter[i]].health);
					}
				}
			}
			tempEnemyArray.splice(0);
			tempEnemyArrayCounter.splice(0);		
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